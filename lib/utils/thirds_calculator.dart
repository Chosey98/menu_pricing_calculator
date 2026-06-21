import '../l10n/app_localizations.dart';

enum ThirdsStatus { under, onTarget, over }

class BusinessThirdsTargets {
  final double totalVariableCosts;
  final double totalRevenueTarget;
  final double targetRawMaterialBudget;
  final double targetProfit;

  const BusinessThirdsTargets({
    required this.totalVariableCosts,
    required this.totalRevenueTarget,
    required this.targetRawMaterialBudget,
    required this.targetProfit,
  });

  /// Each third (raw, variable, profit) equals the variable-cost total.
  double get revenuePerThird => totalVariableCosts;
}

class ItemThirdsAnalysis {
  final double sellingPrice;
  final double targetRawCost;
  final double actualRawCost;
  final double rawGap;
  final double targetVariable;
  final double targetProfit;
  final ThirdsStatus status;
  final double? minimumPriceForActualRaw;

  const ItemThirdsAnalysis({
    required this.sellingPrice,
    required this.targetRawCost,
    required this.actualRawCost,
    required this.rawGap,
    required this.targetVariable,
    required this.targetProfit,
    required this.status,
    this.minimumPriceForActualRaw,
  });
}

BusinessThirdsTargets calculateBusinessThirdsTargets({
  required double totalVariableCosts,
}) {
  return BusinessThirdsTargets(
    totalVariableCosts: totalVariableCosts,
    totalRevenueTarget: totalVariableCosts * 3,
    targetRawMaterialBudget: totalVariableCosts,
    targetProfit: totalVariableCosts,
  );
}

BusinessThirdsTargets calculateBusinessThirdsFromCategories(
  List<double> categoryAmounts,
) {
  final total = categoryAmounts.fold<double>(0, (sum, amount) => sum + amount);
  return calculateBusinessThirdsTargets(totalVariableCosts: total);
}

ItemThirdsAnalysis analyzeItemThirds({
  required double actualRawCost,
  required double cascadeFinalPrice,
  double? actualSalesPrice,
  double tolerance = 0.01,
}) {
  final sellingPrice = (actualSalesPrice != null && actualSalesPrice > 0)
      ? actualSalesPrice
      : cascadeFinalPrice;

  if (sellingPrice <= 0) {
    return ItemThirdsAnalysis(
      sellingPrice: 0,
      targetRawCost: 0,
      actualRawCost: actualRawCost,
      rawGap: 0,
      targetVariable: 0,
      targetProfit: 0,
      status: ThirdsStatus.onTarget,
      minimumPriceForActualRaw:
          actualRawCost > 0 ? actualRawCost * 3 : null,
    );
  }

  final third = sellingPrice / 3;
  final rawGap = actualRawCost - third;
  ThirdsStatus status;
  if (rawGap.abs() <= tolerance) {
    status = ThirdsStatus.onTarget;
  } else if (rawGap > 0) {
    status = ThirdsStatus.over;
  } else {
    status = ThirdsStatus.under;
  }

  return ItemThirdsAnalysis(
    sellingPrice: sellingPrice,
    targetRawCost: third,
    actualRawCost: actualRawCost,
    rawGap: rawGap,
    targetVariable: third,
    targetProfit: third,
    status: status,
    minimumPriceForActualRaw: actualRawCost > 0 ? actualRawCost * 3 : null,
  );
}

String buildThirdsGuidance(
  ItemThirdsAnalysis analysis,
  String currencyLabel,
  AppLocalizations l10n,
) {
  if (analysis.sellingPrice <= 0) {
    if (analysis.actualRawCost > 0) {
      final minPrice = analysis.actualRawCost * 3;
      return l10n.thirdsGuidanceNoPriceWithRaw(
        '${minPrice.toStringAsFixed(2)} $currencyLabel',
      );
    }
    return l10n.thirdsGuidanceNoData;
  }

  final gap = analysis.rawGap.abs();
  final gapText = '${gap.toStringAsFixed(2)} $currencyLabel';

  switch (analysis.status) {
    case ThirdsStatus.onTarget:
      return l10n.thirdsGuidanceOnTarget;
    case ThirdsStatus.over:
      final minPrice = analysis.minimumPriceForActualRaw;
      if (minPrice != null) {
        final pricePart = l10n.thirdsMinPrice(
          '${minPrice.toStringAsFixed(2)} $currencyLabel',
        );
        return l10n.thirdsGuidanceOver(
          gapText,
          '$pricePart${l10n.thirdsRaiseOrReduce}',
        );
      }
      return l10n.thirdsGuidanceOverReduce(gapText);
    case ThirdsStatus.under:
      return l10n.thirdsGuidanceUnder(gapText);
  }
}
