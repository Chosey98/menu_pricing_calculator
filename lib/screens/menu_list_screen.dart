import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/localization_provider.dart';
import '../providers/menu_items_provider.dart';
import '../providers/pricing_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/thirds_analysis_provider.dart';
import '../utils/currency_formatter.dart';
import '../utils/thirds_calculator.dart';
import 'app_settings_screen.dart';
import 'business_plan_screen.dart';
import 'ingredients_purchase_screen.dart';
import 'item_detail_screen.dart';
import 'monthly_sales_screen.dart';
import 'sales_targets_screen.dart';
import 'setup_guide_screen.dart';

class MenuListScreen extends ConsumerWidget {
  const MenuListScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
    String name,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteMenuItemTitle),
        content: Text(l10n.deleteMenuItemBody(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(menuItemsProvider.notifier).deleteItem(id);
    }
  }

  Future<void> _duplicateItem(
    BuildContext context,
    WidgetRef ref,
    item,
    AppLocalizations l10n,
  ) async {
    final duplicated = await ref.read(menuItemsProvider.notifier).duplicateItem(
          item,
          copyName: l10n.copySuffix(item.name),
        );
    if (!context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailScreen(itemId: duplicated.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(menuItemsProvider);
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final hasBusinessData = ref.watch(businessPlanHasDataProvider);
    final businessTargets = ref.watch(businessThirdsTargetsProvider);
    final menuRawOnceEach = ref.watch(menuRawCostOnceEachProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuPricing),
        actions: [
          IconButton(
            tooltip: l10n.monthlySales,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MonthlySalesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.bar_chart_outlined),
          ),
          IconButton(
            tooltip: l10n.salesTargets,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesTargetsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.track_changes_outlined),
          ),
          IconButton(
            tooltip: l10n.ingredientsPurchase,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const IngredientsPurchaseScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            tooltip: l10n.businessPlan,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BusinessPlanScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_balance),
          ),
          IconButton(
            tooltip: l10n.setupGuide,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SetupGuideScreen(),
                ),
              );
            },
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            tooltip: l10n.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppSettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noMenuItemsYet,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.emptyMenuHint,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SetupGuideScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.menu_book_outlined),
                      label: Text(l10n.openSetupGuide),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AppSettingsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings),
                      label: Text(l10n.openSettings),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                if (hasBusinessData && items.isNotEmpty)
                  _BusinessPlanBanner(
                    menuRawOnceEach: menuRawOnceEach,
                    rawBudget: businessTargets.targetRawMaterialBudget,
                    currencyLabel: settings.currencyLabel,
                    l10n: l10n,
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final breakdown = ref.watch(
                        pricingBreakdownProvider(
                          PricingInput(
                            ingredients: item.ingredients,
                            actualSalesPrice: item.actualSalesPrice,
                          ),
                        ),
                      );
                      final thirdsAnalysis =
                          ref.watch(itemThirdsAnalysisProvider(item.id));

                      return Dismissible(
                        key: ValueKey(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: const EdgeInsetsDirectional.only(end: 20),
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: Icon(
                            Icons.delete_outline,
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                        confirmDismiss: (_) async {
                          await _confirmDelete(
                            context,
                            ref,
                            item.id,
                            item.name,
                            l10n,
                          );
                          return false;
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ItemDetailScreen(itemId: item.id),
                                ),
                              );
                            },
                            onLongPress: () async {
                              final action = await showModalBottomSheet<String>(
                                context: context,
                                builder: (context) => SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.copy),
                                        title: Text(l10n.duplicate),
                                        onTap: () =>
                                            Navigator.pop(context, 'duplicate'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete_outline),
                                        title: Text(l10n.delete),
                                        onTap: () =>
                                            Navigator.pop(context, 'delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              if (!context.mounted) return;
                              if (action == 'duplicate') {
                                await _duplicateItem(context, ref, item, l10n);
                              } else if (action == 'delete') {
                                await _confirmDelete(
                                  context,
                                  ref,
                                  item.id,
                                  item.name,
                                  l10n,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          l10n.dCost(formatCurrency(
                                            breakdown.totalDirectCost,
                                            settings.currencyLabel,
                                          )),
                                        ),
                                        if (thirdsAnalysis != null &&
                                            thirdsAnalysis.status ==
                                                ThirdsStatus.over)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Chip(
                                              label: Text(l10n.overThirdsRaw),
                                              visualDensity:
                                                  VisualDensity.compact,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .errorContainer,
                                            ),
                                          ),
                                        if (item.addOns.isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Chip(
                                              label: Text(
                                                l10n.addOnCount(
                                                  item.addOns.length,
                                                ),
                                              ),
                                              visualDensity:
                                                  VisualDensity.compact,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatCurrency(
                                      breakdown.finalPrice,
                                      settings.currencyLabel,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final item = await ref.read(menuItemsProvider.notifier).addItem(
                name: l10n.newMenuItemDefault,
              );
          if (!context.mounted) return;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ItemDetailScreen(itemId: item.id),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.newMenuItem),
      ),
    );
  }
}

class _BusinessPlanBanner extends StatelessWidget {
  const _BusinessPlanBanner({
    required this.menuRawOnceEach,
    required this.rawBudget,
    required this.currencyLabel,
    required this.l10n,
  });

  final double menuRawOnceEach;
  final double rawBudget;
  final String currencyLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overBudget = menuRawOnceEach > rawBudget;
    final delta = menuRawOnceEach - rawBudget;

    return Material(
      color: overBudget
          ? theme.colorScheme.errorContainer
          : theme.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.businessPlanBannerTitle,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.menuRawTotal(
                formatCurrency(menuRawOnceEach, currencyLabel),
                formatCurrency(rawBudget, currencyLabel),
              ),
            ),
            if (overBudget)
              Text(
                l10n.overBudgetBy(formatCurrency(delta, currencyLabel)),
                style: TextStyle(color: theme.colorScheme.onErrorContainer),
              ),
          ],
        ),
      ),
    );
  }
}
