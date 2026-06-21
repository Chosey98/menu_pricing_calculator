import 'package:hive/hive.dart';

import 'ingredient_line.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 6)
class ShoppingList {
  @HiveField(0)
  final List<IngredientLine> items;

  @HiveField(1)
  final DateTime updatedAt;

  const ShoppingList({
    required this.items,
    required this.updatedAt,
  });

  ShoppingList copyWith({
    List<IngredientLine>? items,
    DateTime? updatedAt,
  }) {
    return ShoppingList(
      items: items ?? this.items,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get totalCost =>
      items.fold<double>(0, (sum, line) => sum + line.lineTotal);
}
