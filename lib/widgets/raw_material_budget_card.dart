import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../providers/shopping_list_provider.dart';
import '../utils/currency_formatter.dart';

class RawMaterialBudgetCard extends StatelessWidget {
  const RawMaterialBudgetCard({
    super.key,
    required this.comparison,
    required this.currencyLabel,
    required this.l10n,
  });

  final BudgetComparison comparison;
  final String currencyLabel;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasBudget = comparison.budget > 0;
    final progress = hasBudget
        ? (comparison.spent / comparison.budget).clamp(0.0, 1.5)
        : 0.0;

    return Card(
      color: comparison.isOverBudget
          ? theme.colorScheme.errorContainer
          : theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.rawMaterialPurchases,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _line(context, l10n.rawMaterialBudget, comparison.budget),
            _line(context, l10n.purchasesTotal, comparison.spent,
                emphasized: true),
            if (hasBudget) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress > 1 ? 1 : progress,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                color: comparison.isOverBudget
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                comparison.isOverBudget
                    ? l10n.overBudgetBy(
                        formatCurrency(comparison.remaining.abs(), currencyLabel),
                      )
                    : l10n.remainingBudget(
                        formatCurrency(comparison.remaining, currencyLabel),
                      ),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: comparison.isOverBudget
                      ? theme.colorScheme.onErrorContainer
                      : theme.colorScheme.primary,
                ),
              ),
            ] else
              Text(
                l10n.setVariableCostsForBudget,
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    String label,
    double value, {
    bool emphasized = false,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        formatCurrency(value, currencyLabel),
        style: emphasized
            ? Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )
            : Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
