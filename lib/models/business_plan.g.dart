// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessPlanAdapter extends TypeAdapter<BusinessPlan> {
  @override
  final int typeId = 5;

  @override
  BusinessPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessPlan(
      categories: (fields[0] as List).cast<VariableCostCategory>(),
      updatedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessPlan obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categories)
      ..writeByte(1)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
