import '../models/app_settings.dart';
import '../models/ingredient_line.dart';

class PricingBreakdown {
  final double totalDirectCost;
  final double packingCost;
  final double electricCost;
  final double salaryCost;
  final double profit;
  final double rentCost;
  final double totalCostAndProfit;
  final double vat;
  final double finalPrice;
  final double? costPercentage;

  const PricingBreakdown({
    required this.totalDirectCost,
    required this.packingCost,
    required this.electricCost,
    required this.salaryCost,
    required this.profit,
    required this.rentCost,
    required this.totalCostAndProfit,
    required this.vat,
    required this.finalPrice,
    this.costPercentage,
  });
}

PricingBreakdown calculatePricing({
  required List<IngredientLine> ingredients,
  required AppSettings settings,
  double? actualSalesPrice,
  double? salaryPctOverride,
}) {
  final totalDirectCost = ingredients.fold<double>(
    0,
    (sum, line) => sum + line.lineTotal,
  );

  final packingCost = totalDirectCost * settings.packingPct;
  final electricCost = (totalDirectCost + packingCost) * settings.electricPct;
  final salaryPct = salaryPctOverride ?? settings.salaryPct;
  final salaryCost =
      (totalDirectCost + packingCost + electricCost) * salaryPct;
  final profit =
      (totalDirectCost + packingCost + electricCost + salaryCost) *
      settings.profitPct;
  // Rent intentionally excludes totalDirectCost — matches source spreadsheets.
  final rentCost =
      (packingCost + electricCost + salaryCost + profit) * settings.rentPct;
  final totalCostAndProfit = totalDirectCost +
      packingCost +
      electricCost +
      salaryCost +
      profit +
      rentCost;
  final vat = totalCostAndProfit * settings.vatPct;
  final finalPrice = totalCostAndProfit + vat;

  double? costPercentage;
  if (actualSalesPrice != null && actualSalesPrice > 0) {
    costPercentage =
        (packingCost + electricCost + salaryCost + profit + rentCost) /
        actualSalesPrice;
  }

  return PricingBreakdown(
    totalDirectCost: totalDirectCost,
    packingCost: packingCost,
    electricCost: electricCost,
    salaryCost: salaryCost,
    profit: profit,
    rentCost: rentCost,
    totalCostAndProfit: totalCostAndProfit,
    vat: vat,
    finalPrice: finalPrice,
    costPercentage: costPercentage,
  );
}
