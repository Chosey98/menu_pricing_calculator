import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/ingredient_line.dart';
import '../models/menu_item.dart';
import '../models/shopping_list.dart';
import 'thirds_analysis_provider.dart';

const shoppingListBoxName = 'shopping_list';
const shoppingListKey = 'shopping_list';
const _uuid = Uuid();

class ShoppingListRepository {
  Box<ShoppingList> get _box => Hive.box<ShoppingList>(shoppingListBoxName);

  ShoppingList load() {
    return _box.get(shoppingListKey) ??
        ShoppingList(items: const [], updatedAt: DateTime.now());
  }

  Future<void> save(ShoppingList list) async {
    await _box.put(
      shoppingListKey,
      list.copyWith(updatedAt: DateTime.now()),
    );
  }
}

class ShoppingListNotifier extends StateNotifier<ShoppingList> {
  ShoppingListNotifier(this._repository) : super(_repository.load());

  final ShoppingListRepository _repository;

  Future<void> _persist(ShoppingList list) async {
    state = list;
    await _repository.save(list);
  }

  Future<void> addItem() async {
    await _persist(
      state.copyWith(
        items: [
          ...state.items,
          IngredientLine(
            id: _uuid.v4(),
            name: '',
            unit: 'kg',
            unitPrice: 0,
            quantityUsed: 0,
          ),
        ],
      ),
    );
  }

  Future<void> updateItem(IngredientLine item) async {
    await _persist(
      state.copyWith(
        items: state.items
            .map((entry) => entry.id == item.id ? item : entry)
            .toList(),
      ),
    );
  }

  Future<void> deleteItem(String id) async {
    await _persist(
      state.copyWith(
        items: state.items.where((entry) => entry.id != id).toList(),
      ),
    );
  }

  Future<void> replaceFromMenuItems(List<MenuItem> menuItems) async {
    final merged = <String, IngredientLine>{};

    for (final menuItem in menuItems) {
      for (final line in menuItem.ingredients) {
        if (line.name.trim().isEmpty && line.lineTotal == 0) continue;
        final key = '${line.name.trim().toLowerCase()}|${line.unit.trim().toLowerCase()}';
        final existing = merged[key];
        if (existing == null) {
          merged[key] = line.copyWith(id: _uuid.v4());
        } else {
          merged[key] = existing.copyWith(
            quantityUsed: existing.quantityUsed + line.quantityUsed,
            unitPrice: line.unitPrice > 0 ? line.unitPrice : existing.unitPrice,
          );
        }
      }
    }

    await _persist(
      state.copyWith(items: merged.values.toList()),
    );
  }

  Future<void> clearAll() async {
    await _persist(state.copyWith(items: const []));
  }
}

final shoppingListRepositoryProvider = Provider<ShoppingListRepository>((ref) {
  return ShoppingListRepository();
});

final shoppingListProvider =
    StateNotifierProvider<ShoppingListNotifier, ShoppingList>((ref) {
  return ShoppingListNotifier(ref.watch(shoppingListRepositoryProvider));
});

final shoppingListTotalProvider = Provider<double>((ref) {
  return ref.watch(shoppingListProvider).totalCost;
});

class BudgetComparison {
  final double budget;
  final double spent;
  final double remaining;
  final bool isOverBudget;
  final double profitTarget;
  final double overBudgetAmount;
  final double estimatedProfitAfterPurchases;

  const BudgetComparison({
    required this.budget,
    required this.spent,
    required this.remaining,
    required this.isOverBudget,
    required this.profitTarget,
    required this.overBudgetAmount,
    required this.estimatedProfitAfterPurchases,
  });
}

final rawMaterialBudgetComparisonProvider = Provider<BudgetComparison>((ref) {
  final businessTargets = ref.watch(businessThirdsTargetsProvider);
  final budget = businessTargets.targetRawMaterialBudget;
  final profitTarget = businessTargets.targetProfit;
  final spent = ref.watch(shoppingListTotalProvider);
  final remaining = budget - spent;
  final overBudgetAmount =
      budget > 0 && spent > budget ? spent - budget : 0.0;
  final estimatedProfitAfterPurchases = profitTarget - overBudgetAmount;

  return BudgetComparison(
    budget: budget,
    spent: spent,
    remaining: remaining,
    isOverBudget: spent > budget && budget > 0,
    profitTarget: profitTarget,
    overBudgetAmount: overBudgetAmount,
    estimatedProfitAfterPurchases: estimatedProfitAfterPurchases,
  );
});