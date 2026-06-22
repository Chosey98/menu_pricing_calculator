import '../models/ingredient_line.dart';
import '../models/menu_item.dart';

enum IngredientCatalogSource { purchase, recipe }

class CatalogIngredient {
  final String name;
  final String unit;
  final double unitPrice;
  final IngredientCatalogSource source;

  const CatalogIngredient({
    required this.name,
    required this.unit,
    required this.unitPrice,
    required this.source,
  });

  String get key => '${name.trim().toLowerCase()}|${unit.trim().toLowerCase()}';
}

List<CatalogIngredient> buildIngredientCatalog({
  required List<IngredientLine> purchases,
  required List<MenuItem> menuItems,
}) {
  final merged = <String, CatalogIngredient>{};

  void addLine(
    IngredientLine line,
    IngredientCatalogSource source, {
    bool preferExisting = false,
  }) {
    if (line.name.trim().isEmpty) return;
    final entry = CatalogIngredient(
      name: line.name.trim(),
      unit: line.unit.trim().isEmpty ? 'kg' : line.unit.trim(),
      unitPrice: line.unitPrice,
      source: source,
    );
    final existing = merged[entry.key];
    if (existing == null) {
      merged[entry.key] = entry;
      return;
    }
    if (preferExisting) {
      merged[entry.key] = CatalogIngredient(
        name: existing.name,
        unit: existing.unit,
        unitPrice: line.unitPrice > 0 ? line.unitPrice : existing.unitPrice,
        source: existing.source,
      );
    } else if (line.unitPrice > 0 && existing.unitPrice <= 0) {
      merged[entry.key] = CatalogIngredient(
        name: existing.name,
        unit: existing.unit,
        unitPrice: line.unitPrice,
        source: existing.source,
      );
    }
  }

  for (final line in purchases) {
    addLine(line, IngredientCatalogSource.purchase, preferExisting: true);
  }

  for (final menuItem in menuItems) {
    for (final line in menuItem.ingredients) {
      addLine(line, IngredientCatalogSource.recipe);
    }
    for (final addOn in menuItem.addOns) {
      for (final line in addOn.ingredients) {
        addLine(line, IngredientCatalogSource.recipe);
      }
    }
  }

  final list = merged.values.toList()
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return list;
}
