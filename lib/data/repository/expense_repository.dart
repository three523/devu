import 'package:devu_app/data/model/day_expense.dart';
import 'package:devu_app/data/model/expense.dart';
import 'package:devu_app/extenstion.dart';
import 'package:hive/hive.dart';

class ExpenseRepository {
  final Box<DayExpense> expenseBox = Hive.box<DayExpense>('expense');

  Future<void> createExpense(DateTime date, Expense newExpense) async {
    final int key = dateTimeToUnixTimestamp(date);
    final DayExpense? dayExpense = expenseBox.get(key);
    if (dayExpense != null) {
      dayExpense.expenseList.add(newExpense);
      await expenseBox.put(key, dayExpense);
    } else {
      final DayExpense newDayExpense =
          DayExpense(timeStamp: key, expenseList: [newExpense]);
      await expenseBox.put(key, newDayExpense);
    }
  }

  Future<void> updateExpense(
      DateTime date, String id, Expense updatedExpense) async {
    final int key = dateTimeToUnixTimestamp(date);
    final DayExpense? dayExpense = expenseBox.get(key);
    if (dayExpense != null) {
      final int index =
          dayExpense.expenseList.indexWhere((expense) => expense.id == id);
      if (index != -1) {
        dayExpense.expenseList[index] = updatedExpense;
        await expenseBox.put(key, dayExpense);
      }
    }
  }

  Future<void> deleteExpense(DateTime date, String id) async {
    final int key = dateTimeToUnixTimestamp(date);
    final DayExpense? dayExpense = expenseBox.get(key);
    if (dayExpense != null) {
      dayExpense.expenseList.removeWhere((expense) => expense.id == id);
      await expenseBox.put(key, dayExpense);
    }
  }

  List<Expense> getExpensesByDate(DateTime date) {
    final int key = dateTimeToUnixTimestamp(date);
    final DayExpense? dayExpense = expenseBox.get(key);
    print("repository: ${dayExpense?.expenseList}");
    return dayExpense?.expenseList ?? [];
  }

  int dateTimeToUnixTimestamp(DateTime dateTime) {
    return dateTime.withoutTime.millisecondsSinceEpoch ~/ 1000;
  }
}
