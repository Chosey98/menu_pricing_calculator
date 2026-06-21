import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/add_on.dart';
import '../models/ingredient_line.dart';
import '../models/menu_item.dart';

const menuItemsBoxName = 'menu_items';
const _uuid = Uuid();

class MenuItemsRepository {
  Box<MenuItem> get _box => Hive.box<MenuItem>(menuItemsBoxName);

  List<MenuItem> loadAll() {
    try {
      return _box.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (_) {
      return const [];
    }
  }

  MenuItem? loadById(String id) {
    try {
      return _box.get(id);
    } catch (_) {
      return null;
    }
  }

  Future<void> save(MenuItem item) async {
    await _box.put(item.id, item);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }
}

class MenuItemsNotifier extends StateNotifier<List<MenuItem>> {
  MenuItemsNotifier(this._repository) : super(_repository.loadAll());

  final MenuItemsRepository _repository;

  Future<void> refresh() async {
    state = _repository.loadAll();
  }

  Future<MenuItem> addItem({String name = 'New Menu Item'}) async {
    final item = MenuItem(
      id: _uuid.v4(),
      name: name,
      ingredients: const [],
      createdAt: DateTime.now(),
    );
    await _repository.save(item);
    state = _repository.loadAll();
    return item;
  }

  Future<void> updateItem(MenuItem item) async {
    await _repository.save(item);
    state = _repository.loadAll();
  }

  Future<void> deleteItem(String id) async {
    await _repository.delete(id);
    state = _repository.loadAll();
  }

  Future<MenuItem> duplicateItem(MenuItem item, {required String copyName}) async {
    final newId = _uuid.v4();
    final duplicated = MenuItem(
      id: newId,
      name: copyName,
      ingredients: item.ingredients
          .map(
            (line) => line.copyWith(id: _uuid.v4()),
          )
          .toList(),
      actualSalesPrice: item.actualSalesPrice,
      compareScenarios: item.compareScenarios,
      addOns: item.addOns
          .map(
            (addon) => addon.copyWith(
              id: _uuid.v4(),
              parentItemId: newId,
              ingredients: addon.ingredients
                  .map((line) => line.copyWith(id: _uuid.v4()))
                  .toList(),
            ),
          )
          .toList(),
      notes: item.notes,
      expectedMonthlyUnits: item.expectedMonthlyUnits,
      createdAt: DateTime.now(),
    );
    await _repository.save(duplicated);
    state = _repository.loadAll();
    return duplicated;
  }
}

final menuItemsRepositoryProvider = Provider<MenuItemsRepository>((ref) {
  return MenuItemsRepository();
});

final menuItemsProvider =
    StateNotifierProvider<MenuItemsNotifier, List<MenuItem>>((ref) {
  return MenuItemsNotifier(ref.watch(menuItemsRepositoryProvider));
});

final menuItemProvider = Provider.family<MenuItem?, String>((ref, id) {
  final items = ref.watch(menuItemsProvider);
  for (final item in items) {
    if (item.id == id) return item;
  }
  return ref.watch(menuItemsRepositoryProvider).loadById(id);
});

IngredientLine newIngredientLine() {
  return IngredientLine(
    id: _uuid.v4(),
    name: '',
    unit: 'kg',
    unitPrice: 0,
    quantityUsed: 0,
  );
}

AddOn newAddOn(String parentItemId, {String name = 'New Add-on'}) {
  return AddOn(
    id: _uuid.v4(),
    parentItemId: parentItemId,
    name: name,
    ingredients: const [],
  );
}
