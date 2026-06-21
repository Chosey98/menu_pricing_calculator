import 'package:hive/hive.dart';

import 'ingredient_line.dart';

part 'add_on.g.dart';

@HiveType(typeId: 1)
class AddOn {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String parentItemId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final List<IngredientLine> ingredients;

  const AddOn({
    required this.id,
    required this.parentItemId,
    required this.name,
    required this.ingredients,
  });

  AddOn copyWith({
    String? id,
    String? parentItemId,
    String? name,
    List<IngredientLine>? ingredients,
  }) {
    return AddOn(
      id: id ?? this.id,
      parentItemId: parentItemId ?? this.parentItemId,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
