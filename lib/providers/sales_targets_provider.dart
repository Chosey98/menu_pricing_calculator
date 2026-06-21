import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/menu_item.dart';
import '../utils/pricing_calculator.dart';
import '../utils/sales_targets_calculator.dart';
import 'menu_items_provider.dart';
import 'monthly_sales_provider.dart';
import 'pricing_provider.dart';
import 'thirds_analysis_provider.dart';

class ItemPricingSnapshot {
  final double sellingPrice;
  final double rawCostPerUnit;

  const ItemPricingSnapshot({
    required this.sellingPrice,
    required this.rawCostPerUnit,
  });
}

ItemPricingSnapshot pricingSnapshotForItem(
  MenuItem item,
  PricingBreakdown breakdown,
) {
  final sellingPrice = (item.actualSalesPrice != null &&
          item.actualSalesPrice! > 0)
      ? item.actualSalesPrice!
      : breakdown.finalPrice;

  return ItemPricingSnapshot(
    sellingPrice: sellingPrice,
    rawCostPerUnit: breakdown.totalDirectCost,
  );
}

bool itemHasRecipe(MenuItem item, ItemPricingSnapshot pricing) {
  return item.ingredients.isNotEmpty &&
      (pricing.rawCostPerUnit > 0 || pricing.sellingPrice > 0);
}

ItemSalesTarget buildItemSalesTarget({
  required MenuItem item,
  required ItemPricingSnapshot pricing,
  required int? recommendedUnits,
}) {
  final hasRecipe = itemHasRecipe(item, pricing);
  final userUnits = item.expectedMonthlyUnits;
  final usesRecommended = userUnits == null || userUnits <= 0;
  final targetUnits = usesRecommended
      ? (recommendedUnits ?? 0)
      : userUnits;

  return ItemSalesTarget(
    itemId: item.id,
    itemName: item.name,
    sellingPrice: pricing.sellingPrice,
    rawCostPerUnit: pricing.rawCostPerUnit,
    targetUnits: targetUnits,
    usesRecommendedUnits: usesRecommended,
    hasRecipe: hasRecipe,
  );
}

final menuSalesTargetsProvider = Provider<MenuSalesTargetsSummary>((ref) {
  final items = ref.watch(menuItemsProvider);
  final businessTargets = ref.watch(businessThirdsTargetsProvider);

  final pricedItems = <ItemPricingSnapshot>[];
  for (final item in items) {
    final breakdown = ref.watch(
      pricingBreakdownProvider(
        PricingInput(
          ingredients: item.ingredients,
          actualSalesPrice: item.actualSalesPrice,
        ),
      ),
    );
    pricedItems.add(pricingSnapshotForItem(item, breakdown));
  }

  final itemsWithPrice = pricedItems
      .where((pricing) => pricing.sellingPrice > 0)
      .length;

  final targets = <ItemSalesTarget>[];
  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    final pricing = pricedItems[i];
    final recommended = recommendMonthlyUnits(
      businessRevenueTarget: businessTargets.totalRevenueTarget,
      itemSellingPrice: pricing.sellingPrice,
      itemsWithPrice: itemsWithPrice,
    );

    targets.add(
      buildItemSalesTarget(
        item: item,
        pricing: pricing,
        recommendedUnits: recommended,
      ),
    );
  }

  return buildMenuSalesTargets(
    items: targets,
    businessTargets: businessTargets,
  );
});

final itemSalesTargetProvider =
    Provider.family<ItemSalesTarget?, String>((ref, itemId) {
  final summary = ref.watch(menuSalesTargetsProvider);
  for (final target in summary.items) {
    if (target.itemId == itemId) return target;
  }
  return null;
});

final monthlySalesComparisonProvider = Provider<MonthlySalesComparison>((ref) {
  final salesState = ref.watch(monthlySalesProvider);
  final targets = ref.watch(menuSalesTargetsProvider);

  return compareMonthlySales(
    monthKey: salesState.monthKey,
    targets: targets,
    soldByItemId: salesState.record.soldByItemId,
  );
});
