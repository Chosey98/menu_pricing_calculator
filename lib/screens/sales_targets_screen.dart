import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../providers/localization_provider.dart';
import '../providers/sales_targets_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';
import '../utils/sales_targets_calculator.dart';
import '../widgets/sales_targets_summary_card.dart';

class SalesTargetsScreen extends ConsumerWidget {
  const SalesTargetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(menuSalesTargetsProvider);
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.salesTargets),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SalesTargetsSummaryCard(
            summary: summary,
            currencyLabel: settings.currencyLabel,
            l10n: l10n,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.recipeMonthlyTargetsHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          if (summary.itemsWithTargets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                l10n.noMenuItemsForSales,
                textAlign: TextAlign.center,
              ),
            ),
          for (final target in summary.itemsWithTargets)
            _ItemTargetTile(
              target: target,
              currencyLabel: settings.currencyLabel,
              l10n: l10n,
            ),
        ],
      ),
    );
  }
}

class _ItemTargetTile extends StatelessWidget {
  const _ItemTargetTile({
    required this.target,
    required this.currencyLabel,
    required this.l10n,
  });

  final ItemSalesTarget target;
  final String currencyLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unitsLabel = target.usesRecommendedUnits
        ? l10n.recommendedMonthlyUnits
        : l10n.targetMonthlyUnits;

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
            Text('$unitsLabel: ${target.targetUnits}'),
            Text(
              '${l10n.targetMonthlyRevenue}: ${formatCurrency(target.targetRevenue, currencyLabel)}',
            ),
            Text(
              '${l10n.targetMonthlyRawCost}: ${formatCurrency(target.targetRawCost, currencyLabel)}',
            ),
            Text(
              '${l10n.targetMonthlyProfit}: ${formatCurrency(target.targetProfit, currencyLabel)}',
            ),
          ],
        ),
      ),
    );
  }
}

String formatMonthLabel(String monthKey, String localeCode) {
  final date = dateFromMonthKey(monthKey);
  return DateFormat.yMMMM(localeCode).format(date);
}

int? parseIntInput(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  return int.tryParse(trimmed);
}
