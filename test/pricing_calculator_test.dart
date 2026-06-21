import 'package:flutter_test/flutter_test.dart';
import 'package:menu_pricing_calculator/models/app_settings.dart';
import 'package:menu_pricing_calculator/models/ingredient_line.dart';
import 'package:menu_pricing_calculator/utils/pricing_calculator.dart';

void main() {
  const settings = AppSettings.defaults;

  IngredientLine ingredient({
    double unitPrice = 10,
    double quantityUsed = 1,
  }) {
    return IngredientLine(
      id: '1',
      name: 'Test',
      unit: 'kg',
      unitPrice: unitPrice,
      quantityUsed: quantityUsed,
    );
  }

  group('calculatePricing', () {
    test('single ingredient with default settings matches cascade', () {
      final result = calculatePricing(
        ingredients: [ingredient()],
        settings: settings,
      );

      expect(result.totalDirectCost, closeTo(10, 0.0001));
      expect(result.packingCost, closeTo(0.5, 0.0001));
      expect(result.electricCost, closeTo(0.525, 0.0001));
      expect(result.salaryCost, closeTo(5.5125, 0.0001));
      expect(result.profit, closeTo(12.403125, 0.0001));
      expect(result.rentCost, closeTo(2.84109375, 0.0001));
      expect(result.totalCostAndProfit, closeTo(31.78171875, 0.0001));
      expect(result.vat, closeTo(4.449440625, 0.0001));
      expect(result.finalPrice, closeTo(36.231159375, 0.0001));
      expect(result.costPercentage, isNull);
    });

    test('multiple ingredients sum totalDirectCost correctly', () {
      final result = calculatePricing(
        ingredients: [
          ingredient(unitPrice: 10, quantityUsed: 1),
          ingredient(unitPrice: 5, quantityUsed: 2),
          ingredient(unitPrice: 3, quantityUsed: 0.5),
        ],
        settings: settings,
      );

      expect(result.totalDirectCost, closeTo(21.5, 0.0001));
    });

    test('zero ingredients yields all zeros without errors', () {
      final result = calculatePricing(
        ingredients: const [],
        settings: settings,
      );

      expect(result.totalDirectCost, 0);
      expect(result.packingCost, 0);
      expect(result.electricCost, 0);
      expect(result.salaryCost, 0);
      expect(result.profit, 0);
      expect(result.rentCost, 0);
      expect(result.totalCostAndProfit, 0);
      expect(result.vat, 0);
      expect(result.finalPrice, 0);
      expect(result.costPercentage, isNull);
    });

    test('actualSalesPrice computes costPercentage against sales price', () {
      final result = calculatePricing(
        ingredients: [ingredient()],
        settings: settings,
        actualSalesPrice: 40,
      );

      final expectedCostBase = result.packingCost +
          result.electricCost +
          result.salaryCost +
          result.profit +
          result.rentCost;

      expect(result.costPercentage, closeTo(expectedCostBase / 40, 0.0001));
    });

    test('salaryPctOverride changes salary and downstream values only', () {
      final baseline = calculatePricing(
        ingredients: [ingredient()],
        settings: settings,
      );

      final scenarioB = calculatePricing(
        ingredients: [ingredient()],
        settings: settings,
        salaryPctOverride: 0.20,
      );

      expect(scenarioB.packingCost, closeTo(baseline.packingCost, 0.0001));
      expect(scenarioB.electricCost, closeTo(baseline.electricCost, 0.0001));
      expect(scenarioB.salaryCost, closeTo(2.205, 0.0001));
      expect(scenarioB.salaryCost, isNot(closeTo(baseline.salaryCost, 0.0001)));
      expect(scenarioB.profit, closeTo(9.9225, 0.0001));
      expect(scenarioB.rentCost, closeTo(1.972875, 0.0001));
      expect(scenarioB.finalPrice, closeTo(28.6429275, 0.0001));
    });
  });
}
