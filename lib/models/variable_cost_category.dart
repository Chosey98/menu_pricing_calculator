import 'package:hive/hive.dart';

part 'variable_cost_category.g.dart';

@HiveType(typeId: 4)
class VariableCostCategory {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double amount;

  const VariableCostCategory({
    required this.id,
    required this.name,
    required this.amount,
  });

  VariableCostCategory copyWith({
    String? id,
    String? name,
    double? amount,
  }) {
    return VariableCostCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }
}
