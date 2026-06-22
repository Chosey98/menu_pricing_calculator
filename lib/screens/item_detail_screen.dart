import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/menu_item.dart';
import '../providers/localization_provider.dart';
import '../providers/menu_items_provider.dart';
import '../providers/pricing_provider.dart';
import '../providers/sales_targets_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/thirds_analysis_provider.dart';
import '../utils/currency_formatter.dart';
import '../widgets/addon_card.dart';
import '../widgets/ingredient_picker_sheet.dart';
import '../widgets/ingredient_row.dart';
import '../widgets/item_monthly_targets_card.dart';
import '../widgets/pricing_summary_card.dart';
import '../widgets/scenario_comparison_card.dart';
import '../widgets/thirds_target_card.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  const ItemDetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  MenuItem? _draft;
  Timer? _saveTimer;

  @override
  void dispose() {
    _saveTimer?.cancel();
    super.dispose();
  }

  void _scheduleSave(MenuItem item) {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(menuItemsProvider.notifier).updateItem(item);
    });
  }

  void _updateDraft(MenuItem item) {
    setState(() => _draft = item);
    _scheduleSave(item);
  }

  @override
  Widget build(BuildContext context) {
    final storedItem = ref.watch(menuItemProvider(widget.itemId));
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final item = _draft ?? storedItem;

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.itemNotFound)),
        body: Center(child: Text(l10n.itemNoLongerExists)),
      );
    }

    if (_draft == null && storedItem != null) {
      _draft = storedItem;
    }

    final breakdown = ref.watch(
      pricingBreakdownProvider(
        PricingInput(
          ingredients: item.ingredients,
          actualSalesPrice: item.actualSalesPrice,
        ),
      ),
    );
    final thirdsAnalysis = ref.watch(itemThirdsAnalysisProvider(widget.itemId));
    final businessTargets = ref.watch(businessThirdsTargetsProvider);
    final itemSalesTarget = ref.watch(itemSalesTargetProvider(widget.itemId));

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name.isEmpty ? l10n.menuItem : item.name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: PricingSummaryCard(
                breakdown: breakdown,
                settings: settings,
                l10n: l10n,
                actualSalesPrice: item.actualSalesPrice,
              ),
            ),
          ),
          if (thirdsAnalysis != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ThirdsTargetCard(
                  analysis: thirdsAnalysis,
                  currencyLabel: settings.currencyLabel,
                  l10n: l10n,
                  businessTargets: businessTargets.totalVariableCosts > 0
                      ? businessTargets
                      : null,
                ),
              ),
            ),
          if (itemSalesTarget != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ItemMonthlyTargetsCard(
                  target: itemSalesTarget,
                  currencyLabel: settings.currencyLabel,
                  l10n: l10n,
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: item.name,
                    decoration: InputDecoration(
                      labelText: l10n.itemName,
                    ),
                    onChanged: (value) =>
                        _updateDraft(item.copyWith(name: value)),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.ingredients,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final ingredient in item.ingredients)
                    IngredientRow(
                      ingredient: ingredient,
                      currencyLabel: settings.currencyLabel,
                      l10n: l10n,
                      onChanged: (updated) {
                        final ingredients = item.ingredients
                            .map(
                              (line) =>
                                  line.id == updated.id ? updated : line,
                            )
                            .toList();
                        _updateDraft(item.copyWith(ingredients: ingredients));
                      },
                      onDelete: () {
                        final ingredients = item.ingredients
                            .where((line) => line.id != ingredient.id)
                            .toList();
                        _updateDraft(item.copyWith(ingredients: ingredients));
                      },
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final line =
                                await pickIngredientForRecipe(ref, context);
                            if (line == null || !mounted) return;
                            _updateDraft(
                              item.copyWith(
                                ingredients: [...item.ingredients, line],
                              ),
                            );
                          },
                          icon: const Icon(Icons.list_alt_outlined),
                          label: Text(l10n.chooseIngredient),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _updateDraft(
                              item.copyWith(
                                ingredients: [
                                  ...item.ingredients,
                                  newIngredientLine(),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: Text(l10n.addCustomIngredient),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    initialValue: item.actualSalesPrice?.toString() ?? '',
                    decoration: InputDecoration(
                      labelText:
                          '${l10n.actualSalesPrice} (${settings.currencyLabel})',
                      helperText: l10n.actualSalesPriceHelper,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      final parsed = parseDoubleInput(value);
                      if (value.trim().isEmpty) {
                        _updateDraft(item.copyWith(clearActualSalesPrice: true));
                      } else if (parsed != null) {
                        _updateDraft(item.copyWith(actualSalesPrice: parsed));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: item.expectedMonthlyUnits?.toString() ?? '',
                    decoration: InputDecoration(
                      labelText: l10n.expectedMonthlyUnits,
                      helperText: l10n.expectedMonthlyUnitsHelper,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      final trimmed = value.trim();
                      if (trimmed.isEmpty) {
                        _updateDraft(item.copyWith(clearExpectedMonthlyUnits: true));
                      } else {
                        final parsed = int.tryParse(trimmed);
                        if (parsed != null && parsed >= 0) {
                          _updateDraft(
                            item.copyWith(expectedMonthlyUnits: parsed),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.compareSalaryScenarios),
                    subtitle: Text(l10n.compareSalaryScenariosHelper),
                    value: item.compareScenarios,
                    onChanged: (value) =>
                        _updateDraft(item.copyWith(compareScenarios: value)),
                  ),
                  if (item.compareScenarios) ...[
                    const SizedBox(height: 8),
                    ScenarioComparisonCard(
                      ingredients: item.ingredients,
                      actualSalesPrice: item.actualSalesPrice,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.addOns,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          _updateDraft(
                            item.copyWith(
                              addOns: [
                                ...item.addOns,
                                newAddOn(
                                  item.id,
                                  name: l10n.newAddOnDefault,
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: Text(l10n.addAddOn),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (item.addOns.isEmpty) Text(l10n.addOnsEmptyHint),
                  for (final addOn in item.addOns)
                    AddOnCard(
                      addOn: addOn,
                      onChanged: (updated) {
                        final addOns = item.addOns
                            .map((entry) => entry.id == updated.id ? updated : entry)
                            .toList();
                        _updateDraft(item.copyWith(addOns: addOns));
                      },
                      onDelete: () {
                        final addOns = item.addOns
                            .where((entry) => entry.id != addOn.id)
                            .toList();
                        _updateDraft(item.copyWith(addOns: addOns));
                      },
                    ),
                  const SizedBox(height: 24),
                  TextFormField(
                    initialValue: item.notes ?? '',
                    decoration: InputDecoration(
                      labelText: l10n.notesOptional,
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        _updateDraft(item.copyWith(clearNotes: true));
                      } else {
                        _updateDraft(item.copyWith(notes: value));
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
