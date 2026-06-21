import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/currency_formatter.dart';
import '../utils/thirds_calculator.dart';

class BusinessTargetsCard extends StatelessWidget {
  const BusinessTargetsCard({
    super.key,
    required this.targets,
    required this.currencyLabel,
    required this.l10n,
  });

  final BusinessThirdsTargets targets;
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
              l10n.ruleOfThirdsTargets,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.targetsIntro(currencyLabel),
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 24),
            _line(context, l10n.totalVariableCostsEntered, targets.totalVariableCosts),
            _line(
              context,
              l10n.totalRevenueTarget,
              targets.totalRevenueTarget,
              emphasized: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Text(
                l10n.eachThirdEqual,
                style: theme.textTheme.labelLarge,
              ),
            ),
            _line(context, l10n.revenuePerThird, targets.revenuePerThird),
            _line(context, l10n.rawMaterialBudget, targets.targetRawMaterialBudget),
            _line(context, l10n.profitTarget, targets.targetProfit),
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
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(
        formatCurrency(value, currencyLabel),
        style: emphasized
            ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
            : theme.textTheme.bodyLarge,
      ),
    );
  }
}
