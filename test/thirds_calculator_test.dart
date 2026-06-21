import 'package:flutter_test/flutter_test.dart';
import 'package:menu_pricing_calculator/utils/thirds_calculator.dart';

void main() {
  group('calculateBusinessThirdsTargets', () {
    test('variable costs sum to equal revenue, raw, and profit targets', () {
      final result = calculateBusinessThirdsFromCategories([5000, 2000, 1000]);

      expect(result.totalVariableCosts, closeTo(8000, 0.0001));
      expect(result.totalRevenueTarget, closeTo(24000, 0.0001));
      expect(result.revenuePerThird, closeTo(8000, 0.0001));
      expect(result.targetRawMaterialBudget, closeTo(8000, 0.0001));
      expect(result.targetProfit, closeTo(8000, 0.0001));
    });

    test('zero variable costs yields all zero targets', () {
      final result = calculateBusinessThirdsTargets(totalVariableCosts: 0);

      expect(result.totalVariableCosts, 0);
      expect(result.totalRevenueTarget, 0);
      expect(result.targetRawMaterialBudget, 0);
      expect(result.targetProfit, 0);
    });
  });

  group('analyzeItemThirds', () {
    test('selling price 90 with actual raw 35 is over target by 5', () {
      final result = analyzeItemThirds(
        actualRawCost: 35,
        cascadeFinalPrice: 90,
      );

      expect(result.sellingPrice, closeTo(90, 0.0001));
      expect(result.targetRawCost, closeTo(30, 0.0001));
      expect(result.rawGap, closeTo(5, 0.0001));
      expect(result.status, ThirdsStatus.over);
    });

    test('uses actualSalesPrice over cascade finalPrice when set', () {
      final result = analyzeItemThirds(
        actualRawCost: 20,
        cascadeFinalPrice: 90,
        actualSalesPrice: 60,
      );

      expect(result.sellingPrice, closeTo(60, 0.0001));
      expect(result.targetRawCost, closeTo(20, 0.0001));
      expect(result.status, ThirdsStatus.onTarget);
    });

    test('zero selling price handles gracefully', () {
      final result = analyzeItemThirds(
        actualRawCost: 15,
        cascadeFinalPrice: 0,
      );

      expect(result.sellingPrice, 0);
      expect(result.targetRawCost, 0);
      expect(result.minimumPriceForActualRaw, closeTo(45, 0.0001));
    });
  });
}
