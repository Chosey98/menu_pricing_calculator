import 'package:hive/hive.dart';

import 'monthly_sales_line.dart';

part 'monthly_sales_record.g.dart';

@HiveType(typeId: 8)
class MonthlySalesRecord {
  @HiveField(0)
  final String monthKey;

  @HiveField(1)
  final List<MonthlySalesLine> lines;

  @HiveField(2)
  final DateTime updatedAt;

  const MonthlySalesRecord({
    required this.monthKey,
    required this.lines,
    required this.updatedAt,
  });

  MonthlySalesRecord copyWith({
    String? monthKey,
    List<MonthlySalesLine>? lines,
    DateTime? updatedAt,
  }) {
    return MonthlySalesRecord(
      monthKey: monthKey ?? this.monthKey,
      lines: lines ?? this.lines,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int quantityFor(String menuItemId) {
    for (final line in lines) {
      if (line.menuItemId == menuItemId) return line.quantitySold;
    }
    return 0;
  }

  Map<String, int> get soldByItemId {
    return {for (final line in lines) line.menuItemId: line.quantitySold};
  }
}
