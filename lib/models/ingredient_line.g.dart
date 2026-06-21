// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_line.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientLineAdapter extends TypeAdapter<IngredientLine> {
  @override
  final int typeId = 0;

  @override
  IngredientLine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientLine(
      id: fields[0] as String,
      name: fields[1] as String,
      unit: fields[2] as String,
      unitPrice: fields[3] as double,
      quantityUsed: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientLine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.unitPrice)
      ..writeByte(4)
      ..write(obj.quantityUsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientLineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
