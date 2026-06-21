import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/sales_targets_calculator.dart';

class SalesTargetsSummaryCard extends StatelessWidget {
  const SalesTargetsSummaryCard({
    super.key,
    required this.summary,
    required this.currencyLabel,
    required this.l10n,
    this.showBusinessComparison = true,
  });

  final MenuSalesTargetsSummary summary;
  final String currencyLabel;
  final AppLocalizations l10n;
  final bool showBusinessComparison;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.menuTargetsTotal,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _metric(context, l10n.targetMonthlyRevenue, summary.menuTargetRevenue),
            _metric(context, l10n.targetMonthlyRawCost, summary.menuTargetRawCost),
            _metric(context, l10n.targetMonthlyProfit, summary.menuTargetProfit),
            if (showBusinessComparison && summary.hasBusinessTargets) ...[
              const Divider(height: 24),
              Text(
                l10n.businessPlanComparison,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _variance(
                context,
                l10n.totalRevenueTarget,
                summary.businessTargets.totalRevenueTarget,
                summary.revenueGap,
              ),
              _variance(
                context,
                l10n.rawMaterialBudget,
                summary.businessTargets.targetRawMaterialBudget,
                summary.rawGap,
              ),
              _variance(
                context,
                l10n.profitTarget,
                summary.businessTargets.targetProfit,
                summary.profitGap,
              ),
            ] else if (showBusinessComparison) ...[
              const SizedBox(height: 12),
              Text(
                l10n.setBusinessPlanForRecommendations,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _metric(BuildContext context, String label, double value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        formatCurrency(value, currencyLabel),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _variance(
    BuildContext context,
    String label,
    double businessTarget,
    double gap,
  ) {
    final theme = Theme.of(context);
    final isOver = gap > 0.01;
    final isUnder = gap < -0.01;
    final color = isOver
        ? theme.colorScheme.error
        : isUnder
            ? theme.colorScheme.tertiary
            : theme.colorScheme.primary;
    final gapText = formatCurrency(gap.abs(), currencyLabel);
    final statusText = isOver
        ? l10n.aboveTargetBy(gapText)
        : isUnder
            ? l10n.belowTargetBy(gapText)
            : l10n.onTargetStatus;

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(
        statusText,
        style: theme.textTheme.bodySmall?.copyWith(color: color),
      ),
      trailing: Text(
        formatCurrency(businessTarget, currencyLabel),
      ),
    );
  }
}

class MonthlySalesComparisonCard extends StatelessWidget {
  const MonthlySalesComparisonCard({
    super.key,
    required this.comparison,
    required this.currencyLabel,
    required this.l10n,
  });

  final MonthlySalesComparison comparison;
  final String currencyLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.salesComparisonTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _compareLine(
              context,
              l10n.targetMonthlyRevenue,
              comparison.targets.menuTargetRevenue,
              comparison.actualRevenue,
              comparison.revenueVariance,
            ),
            _compareLine(
              context,
              l10n.targetMonthlyRawCost,
              comparison.targets.menuTargetRawCost,
              comparison.actualRawCost,
              comparison.rawVariance,
            ),
            _compareLine(
              context,
              l10n.targetMonthlyProfit,
              comparison.targets.menuTargetProfit,
              comparison.actualProfit,
              comparison.profitVariance,
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareLine(
    BuildContext context,
    String label,
    double target,
    double actual,
    double variance,
  ) {
    final theme = Theme.of(context);
    final isOver = variance > 0.01;
    final isUnder = variance < -0.01;
    final color = isOver
        ? theme.colorScheme.primary
        : isUnder
            ? theme.colorScheme.error
            : theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${l10n.vsTarget}: ${formatCurrency(target, currencyLabel)}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Text(
                formatCurrency(actual, currencyLabel),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            isOver
                ? l10n.aboveTargetBy(formatCurrency(variance, currencyLabel))
                : isUnder
                    ? l10n.belowTargetBy(formatCurrency(variance.abs(), currencyLabel))
                    : l10n.onTargetStatus,
            style: theme.textTheme.bodySmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
