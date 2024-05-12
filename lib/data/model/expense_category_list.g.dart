// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryListAdapter extends TypeAdapter<ExpenseCategoryList> {
  @override
  final int typeId = 6;

  @override
  ExpenseCategoryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseCategoryList(
      fields[0] as int,
      (fields[1] as List).cast<ExpenseCategory>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseCategoryList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.categoryList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
