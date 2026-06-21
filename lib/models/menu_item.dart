import 'package:hive/hive.dart';

import 'add_on.dart';
import 'ingredient_line.dart';

part 'menu_item.g.dart';

@HiveType(typeId: 2)
class MenuItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<IngredientLine> ingredients;

  @HiveField(3)
  final double? actualSalesPrice;

  @HiveField(4)
  final bool compareScenarios;

  @HiveField(5)
  final List<AddOn> addOns;

  @HiveField(6)
  final String? notes;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final int? expectedMonthlyUnits;

  const MenuItem({
    required this.id,
    required this.name,
    required this.ingredients,
    this.actualSalesPrice,
    this.compareScenarios = false,
    this.addOns = const [],
    this.notes,
    required this.createdAt,
    this.expectedMonthlyUnits,
  });

  MenuItem copyWith({
    String? id,
    String? name,
    List<IngredientLine>? ingredients,
    double? actualSalesPrice,
    bool clearActualSalesPrice = false,
    bool? compareScenarios,
    List<AddOn>? addOns,
    String? notes,
    bool clearNotes = false,
    DateTime? createdAt,
    int? expectedMonthlyUnits,
    bool clearExpectedMonthlyUnits = false,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      actualSalesPrice:
          clearActualSalesPrice ? null : (actualSalesPrice ?? this.actualSalesPrice),
      compareScenarios: compareScenarios ?? this.compareScenarios,
      addOns: addOns ?? this.addOns,
      notes: clearNotes ? null : (notes ?? this.notes),
      createdAt: createdAt ?? this.createdAt,
      expectedMonthlyUnits: clearExpectedMonthlyUnits
          ? null
          : (expectedMonthlyUnits ?? this.expectedMonthlyUnits),
    );
  }
}
