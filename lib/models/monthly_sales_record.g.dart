// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_sales_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlySalesRecordAdapter extends TypeAdapter<MonthlySalesRecord> {
  @override
  final int typeId = 8;

  @override
  MonthlySalesRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlySalesRecord(
      monthKey: fields[0] as String,
      lines: (fields[1] as List).cast<MonthlySalesLine>(),
      updatedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlySalesRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.monthKey)
      ..writeByte(1)
      ..write(obj.lines)
      ..writeByte(2)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlySalesRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
