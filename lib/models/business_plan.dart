import 'package:hive/hive.dart';

import 'variable_cost_category.dart';

part 'business_plan.g.dart';

@HiveType(typeId: 5)
class BusinessPlan {
  @HiveField(0)
  final List<VariableCostCategory> categories;

  @HiveField(1)
  final DateTime updatedAt;

  const BusinessPlan({
    required this.categories,
    required this.updatedAt,
  });

  BusinessPlan copyWith({
    List<VariableCostCategory>? categories,
    DateTime? updatedAt,
  }) {
    return BusinessPlan(
      categories: categories ?? this.categories,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
