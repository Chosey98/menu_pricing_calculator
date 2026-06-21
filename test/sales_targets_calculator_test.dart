import 'package:menu_pricing_calculator/utils/sales_targets_calculator.dart';
import 'package:menu_pricing_calculator/utils/thirds_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('recommendMonthlyUnits', () {
    test('splits business revenue evenly across priced items', () {
      expect(
        recommendMonthlyUnits(
          businessRevenueTarget: 9000,
          itemSellingPrice: 30,
          itemsWithPrice: 3,
        ),
        100,
      );
    });

    test('returns null when business target is zero', () {
      expect(
        recommendMonthlyUnits(
          businessRevenueTarget: 0,
          itemSellingPrice: 30,
          itemsWithPrice: 3,
        ),
        isNull,
      );
    });
  });

  group('buildMenuSalesTargets', () {
    test('sums item targets and compares to business plan', () {
      const business = BusinessThirdsTargets(
        totalVariableCosts: 1000,
        totalRevenueTarget: 3000,
        targetRawMaterialBudget: 1000,
        targetProfit: 1000,
      );

      final summary = buildMenuSalesTargets(
        items: const [
          ItemSalesTarget(
            itemId: 'a',
            itemName: 'Burger',
            sellingPrice: 30,
            rawCostPerUnit: 10,
            targetUnits: 50,
            usesRecommendedUnits: false,
            hasRecipe: true,
          ),
          ItemSalesTarget(
            itemId: 'b',
            itemName: 'Fries',
            sellingPrice: 15,
            rawCostPerUnit: 5,
            targetUnits: 100,
            usesRecommendedUnits: true,
            hasRecipe: true,
          ),
        ],
        businessTargets: business,
      );

      expect(summary.menuTargetRevenue, 3000);
      expect(summary.menuTargetRawCost, 1000);
      expect(summary.menuTargetProfit, 1000);
      expect(summary.revenueGap, 0);
      expect(summary.rawGap, 0);
      expect(summary.profitGap, 0);
    });
  });

  group('compareMonthlySales', () {
    test('computes actual totals and variances against menu targets', () {
      const business = BusinessThirdsTargets(
        totalVariableCosts: 1000,
        totalRevenueTarget: 3000,
        targetRawMaterialBudget: 1000,
        targetProfit: 1000,
      );

      final targets = buildMenuSalesTargets(
        items: const [
          ItemSalesTarget(
            itemId: 'a',
            itemName: 'Burger',
            sellingPrice: 30,
            rawCostPerUnit: 10,
            targetUnits: 50,
            usesRecommendedUnits: false,
            hasRecipe: true,
          ),
        ],
        businessTargets: business,
      );

      final comparison = compareMonthlySales(
        monthKey: '2026-06',
        targets: targets,
        soldByItemId: const {'a': 40},
      );

      expect(comparison.actualRevenue, 1200);
      expect(comparison.actualRawCost, 400);
      expect(comparison.actualProfit, 400);
      expect(comparison.revenueVariance, -300);
      expect(comparison.items.single.actualUnits, 40);
      expect(comparison.items.single.unitsVariance, -10);
    });
  });
}
