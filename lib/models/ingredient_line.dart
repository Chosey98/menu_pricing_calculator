import 'package:hive/hive.dart';

part 'ingredient_line.g.dart';

@HiveType(typeId: 0)
class IngredientLine {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  final double unitPrice;

  @HiveField(4)
  final double quantityUsed;

  const IngredientLine({
    required this.id,
    required this.name,
    required this.unit,
    required this.unitPrice,
    required this.quantityUsed,
  });

  double get lineTotal => unitPrice * quantityUsed;

  IngredientLine copyWith({
    String? id,
    String? name,
    String? unit,
    double? unitPrice,
    double? quantityUsed,
  }) {
    return IngredientLine(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      unitPrice: unitPrice ?? this.unitPrice,
      quantityUsed: quantityUsed ?? this.quantityUsed,
    );
  }
}
