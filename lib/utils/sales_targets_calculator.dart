import 'thirds_calculator.dart';

String monthKeyFromDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  return '${date.year}-$month';
}

DateTime dateFromMonthKey(String monthKey) {
  final parts = monthKey.split('-');
  if (parts.length != 2) return DateTime.now();
  final year = int.tryParse(parts[0]) ?? DateTime.now().year;
  final month = int.tryParse(parts[1]) ?? DateTime.now().month;
  return DateTime(year, month);
}

int? recommendMonthlyUnits({
  required double businessRevenueTarget,
  required double itemSellingPrice,
  required int itemsWithPrice,
}) {
  if (businessRevenueTarget <= 0 ||
      itemSellingPrice <= 0 ||
      itemsWithPrice <= 0) {
    return null;
  }
  final revenueShare = businessRevenueTarget / itemsWithPrice;
  return (revenueShare / itemSellingPrice).round().clamp(1, 999999);
}

class ItemSalesTarget {
  final String itemId;
  final String itemName;
  final double sellingPrice;
  final double rawCostPerUnit;
  final int targetUnits;
  final bool usesRecommendedUnits;
  final bool hasRecipe;

  const ItemSalesTarget({
    required this.itemId,
    required this.itemName,
    required this.sellingPrice,
    required this.rawCostPerUnit,
    required this.targetUnits,
    required this.usesRecommendedUnits,
    required this.hasRecipe,
  });

  double get targetRevenue => sellingPrice * targetUnits;

  double get targetRawCost => rawCostPerUnit * targetUnits;

  double get targetProfit => targetRevenue / 3;
}

class MenuSalesTargetsSummary {
  final List<ItemSalesTarget> items;
  final BusinessThirdsTargets businessTargets;
  final double menuTargetRevenue;
  final double menuTargetRawCost;
  final double menuTargetProfit;
  final double revenueGap;
  final double rawGap;
  final double profitGap;

  const MenuSalesTargetsSummary({
    required this.items,
    required this.businessTargets,
    required this.menuTargetRevenue,
    required this.menuTargetRawCost,
    required this.menuTargetProfit,
    required this.revenueGap,
    required this.rawGap,
    required this.profitGap,
  });

  bool get hasBusinessTargets => businessTargets.totalVariableCosts > 0;

  List<ItemSalesTarget> get itemsWithTargets =>
      items.where((item) => item.hasRecipe && item.targetUnits > 0).toList();
}

MenuSalesTargetsSummary buildMenuSalesTargets({
  required List<ItemSalesTarget> items,
  required BusinessThirdsTargets businessTargets,
}) {
  final menuTargetRevenue =
      items.fold<double>(0, (sum, item) => sum + item.targetRevenue);
  final menuTargetRawCost =
      items.fold<double>(0, (sum, item) => sum + item.targetRawCost);
  final menuTargetProfit =
      items.fold<double>(0, (sum, item) => sum + item.targetProfit);

  return MenuSalesTargetsSummary(
    items: items,
    businessTargets: businessTargets,
    menuTargetRevenue: menuTargetRevenue,
    menuTargetRawCost: menuTargetRawCost,
    menuTargetProfit: menuTargetProfit,
    revenueGap: menuTargetRevenue - businessTargets.totalRevenueTarget,
    rawGap: menuTargetRawCost - businessTargets.targetRawMaterialBudget,
    profitGap: menuTargetProfit - businessTargets.targetProfit,
  );
}

class ItemSalesComparison {
  final ItemSalesTarget target;
  final int actualUnits;
  final double actualRevenue;
  final double actualRawCost;
  final double actualProfit;

  const ItemSalesComparison({
    required this.target,
    required this.actualUnits,
    required this.actualRevenue,
    required this.actualRawCost,
    required this.actualProfit,
  });

  int get unitsVariance => actualUnits - target.targetUnits;

  double get revenueVariance => actualRevenue - target.targetRevenue;

  double get rawVariance => actualRawCost - target.targetRawCost;

  double get profitVariance => actualProfit - target.targetProfit;
}

class MonthlySalesComparison {
  final String monthKey;
  final MenuSalesTargetsSummary targets;
  final List<ItemSalesComparison> items;
  final double actualRevenue;
  final double actualRawCost;
  final double actualProfit;
  final double revenueVariance;
  final double rawVariance;
  final double profitVariance;

  const MonthlySalesComparison({
    required this.monthKey,
    required this.targets,
    required this.items,
    required this.actualRevenue,
    required this.actualRawCost,
    required this.actualProfit,
    required this.revenueVariance,
    required this.rawVariance,
    required this.profitVariance,
  });
}

MonthlySalesComparison compareMonthlySales({
  required String monthKey,
  required MenuSalesTargetsSummary targets,
  required Map<String, int> soldByItemId,
}) {
  final comparisons = <ItemSalesComparison>[];

  for (final target in targets.itemsWithTargets) {
    final actualUnits = soldByItemId[target.itemId] ?? 0;
    final actualRevenue = target.sellingPrice * actualUnits;
    final actualRawCost = target.rawCostPerUnit * actualUnits;
    final actualProfit = actualRevenue / 3;

    comparisons.add(
      ItemSalesComparison(
        target: target,
        actualUnits: actualUnits,
        actualRevenue: actualRevenue,
        actualRawCost: actualRawCost,
        actualProfit: actualProfit,
      ),
    );
  }

  final actualRevenue =
      comparisons.fold<double>(0, (sum, item) => sum + item.actualRevenue);
  final actualRawCost =
      comparisons.fold<double>(0, (sum, item) => sum + item.actualRawCost);
  final actualProfit =
      comparisons.fold<double>(0, (sum, item) => sum + item.actualProfit);

  return MonthlySalesComparison(
    monthKey: monthKey,
    targets: targets,
    items: comparisons,
    actualRevenue: actualRevenue,
    actualRawCost: actualRawCost,
    actualProfit: actualProfit,
    revenueVariance: actualRevenue - targets.menuTargetRevenue,
    rawVariance: actualRawCost - targets.menuTargetRawCost,
    profitVariance: actualProfit - targets.menuTargetProfit,
  );
}
