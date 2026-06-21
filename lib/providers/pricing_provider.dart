import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingredient_line.dart';
import '../utils/pricing_calculator.dart';
import 'settings_provider.dart';

class PricingInput {
  final List<IngredientLine> ingredients;
  final double? actualSalesPrice;
  final double? salaryPctOverride;

  const PricingInput({
    required this.ingredients,
    this.actualSalesPrice,
    this.salaryPctOverride,
  });

  @override
  bool operator ==(Object other) {
    return other is PricingInput &&
        other.actualSalesPrice == actualSalesPrice &&
        other.salaryPctOverride == salaryPctOverride &&
        _listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode => Object.hash(
        actualSalesPrice,
        salaryPctOverride,
        Object.hashAll(ingredients),
      );
}

bool _listEquals(List<IngredientLine> a, List<IngredientLine> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    final left = a[i];
    final right = b[i];
    if (left.id != right.id ||
        left.name != right.name ||
        left.unit != right.unit ||
        left.unitPrice != right.unitPrice ||
        left.quantityUsed != right.quantityUsed) {
      return false;
    }
  }
  return true;
}

final pricingBreakdownProvider =
    Provider.family<PricingBreakdown, PricingInput>((ref, input) {
  final settings = ref.watch(appSettingsProvider);
  return calculatePricing(
    ingredients: input.ingredients,
    settings: settings,
    actualSalesPrice: input.actualSalesPrice,
    salaryPctOverride: input.salaryPctOverride,
  );
});
