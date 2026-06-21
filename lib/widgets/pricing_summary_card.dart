import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../utils/currency_formatter.dart';
import '../utils/pricing_calculator.dart';

class PricingSummaryCard extends StatelessWidget {
  const PricingSummaryCard({
    super.key,
    required this.breakdown,
    required this.settings,
    required this.l10n,
    this.compact = false,
    this.actualSalesPrice,
  });

  final PricingBreakdown breakdown;
  final AppSettings settings;
  final AppLocalizations l10n;
  final bool compact;
  final double? actualSalesPrice;

  @override
  Widget build(BuildContext context) {
    final currency = settings.currencyLabel;
    final theme = Theme.of(context);

    return Card(
      elevation: compact ? 0 : 2,
      color: compact
          ? theme.colorScheme.surfaceContainerHighest
          : theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _line(context, l10n.totalDirectCost, breakdown.totalDirectCost, currency),
            _line(
              context,
              l10n.packingPct(formatPercentInput(settings.packingPct)),
              breakdown.packingCost,
              currency,
            ),
            _line(
              context,
              l10n.electricPct(formatPercentInput(settings.electricPct)),
              breakdown.electricCost,
              currency,
            ),
            _line(
              context,
              l10n.salaryPct(formatPercentInput(settings.salaryPct)),
              breakdown.salaryCost,
              currency,
            ),
            _line(
              context,
              l10n.profitPct(formatPercentInput(settings.profitPct)),
              breakdown.profit,
              currency,
            ),
            _line(
              context,
              l10n.rentPct(formatPercentInput(settings.rentPct)),
              breakdown.rentCost,
              currency,
              subtitle: l10n.rentSubtitle,
            ),
            const Divider(height: 24),
            _line(
              context,
              l10n.totalCostAndProfit,
              breakdown.totalCostAndProfit,
              currency,
              emphasized: true,
            ),
            _line(
              context,
              l10n.vatPct(formatPercentInput(settings.vatPct)),
              breakdown.vat,
              currency,
            ),
            const SizedBox(height: 8),
            Text(
              formatCurrency(breakdown.finalPrice, currency),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.finalPrice,
              style: theme.textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            if (actualSalesPrice != null && actualSalesPrice! > 0) ...[
              const Divider(height: 24),
              _line(
                context,
                l10n.actualSalesPriceLabel,
                actualSalesPrice!,
                currency,
              ),
              if (breakdown.costPercentage != null)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.costPercent),
                  trailing: Text(
                    formatPercent(breakdown.costPercentage!),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.varianceVsFinalPrice),
                trailing: Text(
                  formatCurrency(
                    actualSalesPrice! - breakdown.finalPrice,
                    currency,
                  ),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: actualSalesPrice! >= breakdown.finalPrice
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    String label,
    double value,
    String currency, {
    String? subtitle,
    bool emphasized = false,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Text(
        formatCurrency(value, currency),
        style: emphasized
            ? theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge,
      ),
    );
  }
}
