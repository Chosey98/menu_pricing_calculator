import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/monthly_sales_line.dart';
import '../models/monthly_sales_record.dart';
import '../utils/sales_targets_calculator.dart';

const monthlySalesBoxName = 'monthly_sales';

class MonthlySalesRepository {
  Box<MonthlySalesRecord> get _box =>
      Hive.box<MonthlySalesRecord>(monthlySalesBoxName);

  MonthlySalesRecord load(String monthKey) {
    return _box.get(monthKey) ??
        MonthlySalesRecord(
          monthKey: monthKey,
          lines: const [],
          updatedAt: DateTime.now(),
        );
  }

  Future<void> save(MonthlySalesRecord record) async {
    await _box.put(
      record.monthKey,
      record.copyWith(updatedAt: DateTime.now()),
    );
  }
}

class MonthlySalesState {
  final String monthKey;
  final MonthlySalesRecord record;

  const MonthlySalesState({
    required this.monthKey,
    required this.record,
  });
}

class MonthlySalesNotifier extends StateNotifier<MonthlySalesState> {
  MonthlySalesNotifier(this._repository)
      : super(
          MonthlySalesState(
            monthKey: monthKeyFromDate(DateTime.now()),
            record: MonthlySalesRecord(
              monthKey: monthKeyFromDate(DateTime.now()),
              lines: const [],
              updatedAt: DateTime.now(),
            ),
          ),
        ) {
    _loadMonth(state.monthKey);
  }

  final MonthlySalesRepository _repository;

  void _loadMonth(String monthKey) {
    state = MonthlySalesState(
      monthKey: monthKey,
      record: _repository.load(monthKey),
    );
  }

  Future<void> setMonth(String monthKey) async {
    _loadMonth(monthKey);
  }

  Future<void> setMonthFromDate(DateTime date) async {
    await setMonth(monthKeyFromDate(date));
  }

  Future<void> shiftMonth(int delta) async {
    final date = dateFromMonthKey(state.monthKey);
    final shifted = DateTime(date.year, date.month + delta);
    await setMonth(monthKeyFromDate(shifted));
  }

  Future<void> setQuantitySold(String menuItemId, int quantitySold) async {
    final clamped = quantitySold < 0 ? 0 : quantitySold;
    final lines = [...state.record.lines];
    final index = lines.indexWhere((line) => line.menuItemId == menuItemId);

    if (clamped == 0) {
      if (index >= 0) lines.removeAt(index);
    } else if (index >= 0) {
      lines[index] = lines[index].copyWith(quantitySold: clamped);
    } else {
      lines.add(
        MonthlySalesLine(
          menuItemId: menuItemId,
          quantitySold: clamped,
        ),
      );
    }

    final record = state.record.copyWith(lines: lines);
    state = MonthlySalesState(monthKey: state.monthKey, record: record);
    await _repository.save(record);
  }
}

final monthlySalesRepositoryProvider = Provider<MonthlySalesRepository>((ref) {
  return MonthlySalesRepository();
});

final monthlySalesProvider =
    StateNotifierProvider<MonthlySalesNotifier, MonthlySalesState>((ref) {
  return MonthlySalesNotifier(ref.watch(monthlySalesRepositoryProvider));
});
