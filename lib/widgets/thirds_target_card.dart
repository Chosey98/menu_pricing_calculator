import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/thirds_calculator.dart';

class ThirdsTargetCard extends StatelessWidget {
  const ThirdsTargetCard({
    super.key,
    required this.analysis,
    required this.currencyLabel,
    required this.l10n,
    this.businessTargets,
  });

  final ItemThirdsAnalysis analysis;
  final String currencyLabel;
  final AppLocalizations l10n;
  final BusinessThirdsTargets? businessTargets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = switch (analysis.status) {
      ThirdsStatus.onTarget => theme.colorScheme.primary,
      ThirdsStatus.under => theme.colorScheme.tertiary,
      ThirdsStatus.over => theme.colorScheme.error,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.ruleOfThirdsRecipe,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.ruleOfThirdsRecipeHint,
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 24),
            _line(context, l10n.sellingPriceUsed, analysis.sellingPrice),
            _line(context, l10n.targetRawCost, analysis.targetRawCost),
            _line(context, l10n.actualRawCost, analysis.actualRawCost),
            _line(
              context,
              l10n.gap,
              analysis.rawGap,
              valueColor: statusColor,
            ),
            _line(context, l10n.variableShareAtPrice, analysis.targetVariable),
            _line(context, l10n.profitShareAtPrice, analysis.targetProfit),
            if (businessTargets != null &&
                businessTargets!.targetRawMaterialBudget > 0) ...[
              const Divider(height: 16),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.businessRawMaterialBudget),
                trailing: Text(
                  formatCurrency(
                    businessTargets!.targetRawMaterialBudget,
                    currencyLabel,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                buildThirdsGuidance(analysis, currencyLabel, l10n),
                style: theme.textTheme.bodyMedium,
              ),
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
    Color? valueColor,
  }) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        formatCurrency(value, currencyLabel),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: valueColor,
              fontWeight: valueColor != null ? FontWeight.w600 : null,
            ),
      ),
    );
  }
}
