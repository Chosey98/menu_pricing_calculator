import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/thirds_calculator.dart';
import 'business_plan_provider.dart';
import 'menu_items_provider.dart';
import 'pricing_provider.dart';

final businessThirdsTargetsProvider = Provider<BusinessThirdsTargets>((ref) {
  final plan = ref.watch(businessPlanProvider);
  final amounts = plan.categories.map((category) => category.amount).toList();
  return calculateBusinessThirdsFromCategories(amounts);
});

final itemThirdsAnalysisProvider =
    Provider.family<ItemThirdsAnalysis?, String>((ref, itemId) {
  final item = ref.watch(menuItemProvider(itemId));
  if (item == null) return null;

  final breakdown = ref.watch(
    pricingBreakdownProvider(
      PricingInput(
        ingredients: item.ingredients,
        actualSalesPrice: item.actualSalesPrice,
      ),
    ),
  );

  return analyzeItemThirds(
    actualRawCost: breakdown.totalDirectCost,
    cascadeFinalPrice: breakdown.finalPrice,
    actualSalesPrice: item.actualSalesPrice,
  );
});

final menuRawCostOnceEachProvider = Provider<double>((ref) {
  final items = ref.watch(menuItemsProvider);
  var total = 0.0;
  for (final item in items) {
    final breakdown = ref.watch(
      pricingBreakdownProvider(
        PricingInput(
          ingredients: item.ingredients,
          actualSalesPrice: item.actualSalesPrice,
        ),
      ),
    );
    total += breakdown.totalDirectCost;
  }
  return total;
});

final businessPlanHasDataProvider = Provider<bool>((ref) {
  final plan = ref.watch(businessPlanProvider);
  return plan.categories.any((category) => category.amount > 0);
});
