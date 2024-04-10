// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayExpenseAdapter extends TypeAdapter<DayExpense> {
  @override
  final int typeId = 1;

  @override
  DayExpense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayExpense(
      timeStamp: fields[0] as int,
      expenseList: (fields[1] as List).cast<Expense>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayExpense obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.expenseList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
