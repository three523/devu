// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterDataAdapter extends TypeAdapter<FilterData> {
  @override
  final int typeId = 2;

  @override
  FilterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterData(
      key: fields[0] as String,
      dataList: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FilterData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.dataList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
