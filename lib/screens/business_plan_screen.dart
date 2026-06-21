import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/business_plan_provider.dart';
import '../providers/localization_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/thirds_analysis_provider.dart';
import '../providers/sales_targets_provider.dart';
import '../providers/shopping_list_provider.dart';
import '../widgets/business_targets_card.dart';
import '../widgets/variable_cost_category_row.dart';
import 'ingredients_purchase_screen.dart';
import 'monthly_sales_screen.dart';

class BusinessPlanScreen extends ConsumerWidget {
  const BusinessPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(businessPlanProvider);
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final targets = ref.watch(businessThirdsTargetsProvider);
    final purchaseComparison = ref.watch(rawMaterialBudgetComparisonProvider);
    final salesTargets = ref.watch(menuSalesTargetsProvider);
    final notifier = ref.read(businessPlanProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.businessPlan),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BusinessTargetsCard(
            targets: targets,
            currencyLabel: settings.currencyLabel,
            l10n: l10n,
          ),
          if (purchaseComparison.budget > 0 || purchaseComparison.spent > 0) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IngredientsPurchaseScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text(l10n.ingredientsPurchase),
            ),
          ],
          if (salesTargets.itemsWithTargets.isNotEmpty) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MonthlySalesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.bar_chart_outlined),
              label: Text(l10n.monthlySales),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.variableCosts,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              OutlinedButton.icon(
                onPressed: () => notifier.addCategory(),
                icon: const Icon(Icons.add),
                label: Text(l10n.addCategory),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (plan.categories.isEmpty)
            Text(l10n.variableCostsEmptyHint),
          for (final category in plan.categories)
            VariableCostCategoryRow(
              category: category,
              currencyLabel: settings.currencyLabel,
              l10n: l10n,
              onChanged: notifier.updateCategory,
              onDelete: () => notifier.deleteCategory(category.id),
            ),
          const SizedBox(height: 16),
          Text(
            l10n.variableCostsIntro(settings.currencyLabel),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.variableCostsIntroSecondary,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
