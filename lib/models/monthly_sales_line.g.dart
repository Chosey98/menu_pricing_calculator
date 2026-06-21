// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_sales_line.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlySalesLineAdapter extends TypeAdapter<MonthlySalesLine> {
  @override
  final int typeId = 7;

  @override
  MonthlySalesLine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlySalesLine(
      menuItemId: fields[0] as String,
      quantitySold: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlySalesLine obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.menuItemId)
      ..writeByte(1)
      ..write(obj.quantitySold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlySalesLineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
