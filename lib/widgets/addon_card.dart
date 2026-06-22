import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/add_on.dart';
import '../providers/localization_provider.dart';
import '../providers/menu_items_provider.dart';
import '../providers/pricing_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';
import 'ingredient_picker_sheet.dart';
import 'ingredient_row.dart';
import 'pricing_summary_card.dart';

class AddOnCard extends ConsumerStatefulWidget {
  const AddOnCard({
    super.key,
    required this.addOn,
    required this.onChanged,
    required this.onDelete,
  });

  final AddOn addOn;
  final ValueChanged<AddOn> onChanged;
  final VoidCallback onDelete;

  @override
  ConsumerState<AddOnCard> createState() => _AddOnCardState();
}

class _AddOnCardState extends ConsumerState<AddOnCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final breakdown = ref.watch(
      pricingBreakdownProvider(
        PricingInput(ingredients: widget.addOn.ingredients),
      ),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          ListTile(
            title: TextFormField(
              initialValue: widget.addOn.name,
              decoration: InputDecoration(
                labelText: l10n.addOnName,
                isDense: true,
                border: InputBorder.none,
              ),
              onChanged: (value) =>
                  widget.onChanged(widget.addOn.copyWith(name: value)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatCurrency(breakdown.finalPrice, settings.currencyLabel),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  tooltip: l10n.removeAddOn,
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
                IconButton(
                  tooltip: _expanded ? l10n.collapse : l10n.expand,
                  onPressed: () => setState(() => _expanded = !_expanded),
                  icon: Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final ingredient in widget.addOn.ingredients)
                    IngredientRow(
                      ingredient: ingredient,
                      currencyLabel: settings.currencyLabel,
                      l10n: l10n,
                      onChanged: (updated) {
                        final ingredients = widget.addOn.ingredients
                            .map(
                              (line) =>
                                  line.id == updated.id ? updated : line,
                            )
                            .toList();
                        widget.onChanged(
                          widget.addOn.copyWith(ingredients: ingredients),
                        );
                      },
                      onDelete: () {
                        final ingredients = widget.addOn.ingredients
                            .where((line) => line.id != ingredient.id)
                            .toList();
                        widget.onChanged(
                          widget.addOn.copyWith(ingredients: ingredients),
                        );
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
                            widget.onChanged(
                              widget.addOn.copyWith(
                                ingredients: [
                                  ...widget.addOn.ingredients,
                                  line,
                                ],
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
                            widget.onChanged(
                              widget.addOn.copyWith(
                                ingredients: [
                                  ...widget.addOn.ingredients,
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
                  const SizedBox(height: 12),
                  PricingSummaryCard(
                    breakdown: breakdown,
                    settings: settings,
                    l10n: l10n,
                    compact: true,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
