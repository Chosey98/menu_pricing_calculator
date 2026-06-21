// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_on.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddOnAdapter extends TypeAdapter<AddOn> {
  @override
  final int typeId = 1;

  @override
  AddOn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddOn(
      id: fields[0] as String,
      parentItemId: fields[1] as String,
      name: fields[2] as String,
      ingredients: (fields[3] as List).cast<IngredientLine>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddOn obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentItemId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddOnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
