// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kambing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KambingAdapter extends TypeAdapter<Kambing> {
  @override
  final int typeId = 0;

  @override
  Kambing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kambing()
      ..imageBytes = fields[0] as Uint8List
      ..date = fields[1] as DateTime
      ..name = fields[2] as String
      ..price = fields[3] as String
      ..gender = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Kambing obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageBytes)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KambingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
