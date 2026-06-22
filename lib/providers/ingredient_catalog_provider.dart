import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ingredient_catalog.dart';
import 'menu_items_provider.dart';
import 'shopping_list_provider.dart';

final ingredientCatalogProvider = Provider<List<CatalogIngredient>>((ref) {
  final purchases = ref.watch(shoppingListProvider).items;
  final menuItems = ref.watch(menuItemsProvider);
  return buildIngredientCatalog(purchases: purchases, menuItems: menuItems);
});
