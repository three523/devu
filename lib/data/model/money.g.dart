// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyAdapter extends TypeAdapter<Money> {
  @override
  final int typeId = 0;

  @override
  Money read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Money(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as DateTime,
      fields[4] as int,
      fields[5] == null ? [] : (fields[5] as List).cast<Tag>(),
      isInterest: fields[6] == null ? false : fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Money obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.tagList)
      ..writeByte(6)
      ..write(obj.isInterest);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
