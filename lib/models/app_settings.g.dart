// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 3;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      packingPct: fields[0] as double,
      electricPct: fields[1] as double,
      salaryPct: fields[2] as double,
      profitPct: fields[3] as double,
      rentPct: fields[4] as double,
      vatPct: fields[5] as double,
      alternateSalaryPct: fields[6] as double,
      currencyLabel: fields[7] as String,
      localeCode: fields[8] == null ? 'en' : fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.packingPct)
      ..writeByte(1)
      ..write(obj.electricPct)
      ..writeByte(2)
      ..write(obj.salaryPct)
      ..writeByte(3)
      ..write(obj.profitPct)
      ..writeByte(4)
      ..write(obj.rentPct)
      ..writeByte(5)
      ..write(obj.vatPct)
      ..writeByte(6)
      ..write(obj.alternateSalaryPct)
      ..writeByte(7)
      ..write(obj.currencyLabel)
      ..writeByte(8)
      ..write(obj.localeCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
