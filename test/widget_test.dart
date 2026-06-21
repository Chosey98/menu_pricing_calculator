import 'package:flutter_test/flutter_test.dart';
import 'package:menu_pricing_calculator/utils/pricing_calculator.dart';

void main() {
  test('pricing calculator module loads', () {
    expect(calculatePricing, isNotNull);
  });
}
