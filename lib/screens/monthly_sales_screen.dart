import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/localization_provider.dart';
import '../providers/monthly_sales_provider.dart';
import '../providers/sales_targets_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';
import '../utils/sales_targets_calculator.dart';
import '../widgets/sales_targets_summary_card.dart';
import 'sales_targets_screen.dart';

class MonthlySalesScreen extends ConsumerWidget {
  const MonthlySalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesState = ref.watch(monthlySalesProvider);
    final comparison = ref.watch(monthlySalesComparisonProvider);
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final localeCode = settings.localeCode;
    final notifier = ref.read(monthlySalesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.monthlySales),
        actions: [
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              IconButton(
                tooltip: l10n.previousMonth,
                onPressed: () => notifier.shiftMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  formatMonthLabel(salesState.monthKey, localeCode),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              IconButton(
                tooltip: l10n.nextMonth,
                onPressed: () => notifier.shiftMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.monthlySalesHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          MonthlySalesComparisonCard(
            comparison: comparison,
            currencyLabel: settings.currencyLabel,
            l10n: l10n,
          ),
          const SizedBox(height: 16),
          if (comparison.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                l10n.noMenuItemsForSales,
                textAlign: TextAlign.center,
              ),
            ),
          for (final item in comparison.items)
            _MonthlySalesItemCard(
              comparison: item,
              currencyLabel: settings.currencyLabel,
              l10n: l10n,
              onQuantityChanged: (qty) =>
                  notifier.setQuantitySold(item.target.itemId, qty),
            ),
        ],
      ),
    );
  }
}

class _MonthlySalesItemCard extends StatelessWidget {
  const _MonthlySalesItemCard({
    required this.comparison,
    required this.currencyLabel,
    required this.l10n,
    required this.onQuantityChanged,
  });

  final ItemSalesComparison comparison;
  final String currencyLabel;
  final AppLocalizations l10n;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final target = comparison.target;
    final unitsVariance = comparison.unitsVariance;
    final varianceColor = unitsVariance > 0
        ? theme.colorScheme.primary
        : unitsVariance < 0
            ? theme.colorScheme.error
            : theme.colorScheme.onSurface;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              target.itemName.isEmpty ? l10n.menuItem : target.itemName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('${l10n.targetMonthlyUnits}: ${target.targetUnits}'),
            TextFormField(
              initialValue: comparison.actualUnits > 0
                  ? '${comparison.actualUnits}'
                  : '',
              decoration: InputDecoration(
                labelText: l10n.qtySold,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                onQuantityChanged(parseIntInput(value) ?? 0);
              },
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.actualMonthlyRevenue}: ${formatCurrency(comparison.actualRevenue, currencyLabel)}',
            ),
            Text(
              '${l10n.varianceUnits}: $unitsVariance',
              style: theme.textTheme.bodyMedium?.copyWith(color: varianceColor),
            ),
            Text(
              comparison.revenueVariance >= 0
                  ? l10n.aboveTargetBy(
                      formatCurrency(comparison.revenueVariance, currencyLabel),
                    )
                  : l10n.belowTargetBy(
                      formatCurrency(
                        comparison.revenueVariance.abs(),
                        currencyLabel,
                      ),
                    ),
              style: theme.textTheme.bodySmall?.copyWith(color: varianceColor),
            ),
          ],
        ),
      ),
    );
  }
}
