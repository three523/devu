// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetCategoryAdapter extends TypeAdapter<AssetCategory> {
  @override
  final int typeId = 5;

  @override
  AssetCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetCategory(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[5] as int,
      fields[3] as int,
      fields[4] as double,
      (fields[6] as List).cast<Money>(),
      fields[7] as String,
      (fields[8] as List).cast<Tag>(),
    );
  }

  @override
  void write(BinaryWriter writer, AssetCategory obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startTimeStamp)
      ..writeByte(3)
      ..write(obj.goalMoney)
      ..writeByte(4)
      ..write(obj.goalRate)
      ..writeByte(5)
      ..write(obj.goalTimestamp)
      ..writeByte(6)
      ..write(obj.assetList)
      ..writeByte(7)
      ..write(obj.memo)
      ..writeByte(8)
      ..write(obj.tagList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
