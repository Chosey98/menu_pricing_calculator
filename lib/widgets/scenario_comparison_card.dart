import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient_line.dart';
import '../providers/localization_provider.dart';
import '../providers/pricing_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';

class ScenarioComparisonCard extends ConsumerWidget {
  const ScenarioComparisonCard({
    super.key,
    required this.ingredients,
    this.actualSalesPrice,
  });

  final List<IngredientLine> ingredients;
  final double? actualSalesPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final scenarioA = ref.watch(
      pricingBreakdownProvider(
        PricingInput(
          ingredients: ingredients,
          actualSalesPrice: actualSalesPrice,
        ),
      ),
    );
    final scenarioB = ref.watch(
      pricingBreakdownProvider(
        PricingInput(
          ingredients: ingredients,
          actualSalesPrice: actualSalesPrice,
          salaryPctOverride: settings.alternateSalaryPct,
        ),
      ),
    );
    final delta = scenarioB.finalPrice - scenarioA.finalPrice;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.salaryScenarioComparison,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _scenarioColumn(
                    context,
                    title: l10n.scenarioA(
                      formatPercentInput(settings.salaryPct),
                    ),
                    finalPrice: scenarioA.finalPrice,
                    currency: settings.currencyLabel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _scenarioColumn(
                    context,
                    title: l10n.scenarioB(
                      formatPercentInput(settings.alternateSalaryPct),
                    ),
                    finalPrice: scenarioB.finalPrice,
                    currency: settings.currencyLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.difference(formatCurrency(delta, settings.currencyLabel)),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _scenarioColumn(
    BuildContext context, {
    required String title,
    required double finalPrice,
    required String currency,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          Text(title, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            formatCurrency(finalPrice, currency),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
