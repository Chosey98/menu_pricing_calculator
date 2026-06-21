// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_cost_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VariableCostCategoryAdapter extends TypeAdapter<VariableCostCategory> {
  @override
  final int typeId = 4;

  @override
  VariableCostCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariableCostCategory(
      id: fields[0] as String,
      name: fields[1] as String,
      amount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, VariableCostCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariableCostCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
