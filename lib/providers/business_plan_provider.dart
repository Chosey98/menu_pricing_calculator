import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/business_plan.dart';
import '../models/variable_cost_category.dart';

const businessPlanBoxName = 'business_plan';
const businessPlanKey = 'business_plan';
const _uuid = Uuid();

BusinessPlan defaultBusinessPlan() {
  return BusinessPlan(
    categories: [
      VariableCostCategory(id: _uuid.v4(), name: 'Wages', amount: 0),
      VariableCostCategory(id: _uuid.v4(), name: 'Electricity', amount: 0),
      VariableCostCategory(id: _uuid.v4(), name: 'Water', amount: 0),
    ],
    updatedAt: DateTime.now(),
  );
}

class BusinessPlanRepository {
  Box<BusinessPlan> get _box => Hive.box<BusinessPlan>(businessPlanBoxName);

  BusinessPlan load() {
    return _box.get(businessPlanKey) ?? defaultBusinessPlan();
  }

  Future<void> save(BusinessPlan plan) async {
    await _box.put(businessPlanKey, plan);
  }
}

class BusinessPlanNotifier extends StateNotifier<BusinessPlan> {
  BusinessPlanNotifier(this._repository) : super(_repository.load());

  final BusinessPlanRepository _repository;

  Future<void> _persist(BusinessPlan plan) async {
    final updated = plan.copyWith(updatedAt: DateTime.now());
    state = updated;
    await _repository.save(updated);
  }

  Future<void> addCategory({String name = ''}) async {
    await _persist(
      state.copyWith(
        categories: [
          ...state.categories,
          VariableCostCategory(id: _uuid.v4(), name: name, amount: 0),
        ],
      ),
    );
  }

  Future<void> updateCategory(VariableCostCategory category) async {
    await _persist(
      state.copyWith(
        categories: state.categories
            .map((entry) => entry.id == category.id ? category : entry)
            .toList(),
      ),
    );
  }

  Future<void> deleteCategory(String id) async {
    await _persist(
      state.copyWith(
        categories:
            state.categories.where((entry) => entry.id != id).toList(),
      ),
    );
  }
}

final businessPlanRepositoryProvider = Provider<BusinessPlanRepository>((ref) {
  return BusinessPlanRepository();
});

final businessPlanProvider =
    StateNotifierProvider<BusinessPlanNotifier, BusinessPlan>((ref) {
  return BusinessPlanNotifier(ref.watch(businessPlanRepositoryProvider));
});
