import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/sales_targets_calculator.dart';

class ItemMonthlyTargetsCard extends StatelessWidget {
  const ItemMonthlyTargetsCard({
    super.key,
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

    if (!target.hasRecipe || target.sellingPrice <= 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            l10n.addRecipeForTargets,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.recipeMonthlyTargets,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.recipeMonthlyTargetsHint,
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 24),
            _line(
              context,
              target.usesRecommendedUnits
                  ? l10n.recommendedMonthlyUnits
                  : l10n.targetMonthlyUnits,
              '${target.targetUnits}',
            ),
            _line(
              context,
              l10n.targetMonthlyRevenue,
              formatCurrency(target.targetRevenue, currencyLabel),
            ),
            _line(
              context,
              l10n.targetMonthlyRawCost,
              formatCurrency(target.targetRawCost, currencyLabel),
            ),
            _line(
              context,
              l10n.targetMonthlyProfit,
              formatCurrency(target.targetProfit, currencyLabel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(BuildContext context, String label, String value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
