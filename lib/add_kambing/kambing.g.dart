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
      ..image = fields[0] as String
      ..date = fields[1] as DateTime
      ..age = fields[2] as String
      ..name = fields[3] as String
      ..price = fields[4] as String
      ..gender = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Kambing obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
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
