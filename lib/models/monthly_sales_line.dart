import 'package:hive/hive.dart';

part 'monthly_sales_line.g.dart';

@HiveType(typeId: 7)
class MonthlySalesLine {
  @HiveField(0)
  final String menuItemId;

  @HiveField(1)
  final int quantitySold;

  const MonthlySalesLine({
    required this.menuItemId,
    required this.quantitySold,
  });

  MonthlySalesLine copyWith({
    String? menuItemId,
    int? quantitySold,
  }) {
    return MonthlySalesLine(
      menuItemId: menuItemId ?? this.menuItemId,
      quantitySold: quantitySold ?? this.quantitySold,
    );
  }
}
