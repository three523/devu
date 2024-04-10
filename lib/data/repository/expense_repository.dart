import 'package:devu_app/data/model/filter_data.dart';
import 'package:devu_app/data/model/day_expense.dart';
import 'package:devu_app/data/model/expense.dart';
import 'package:devu_app/extenstion.dart';
import 'package:hive/hive.dart';

enum FilterType { category, label }

class ExpenseRepository {
  final Box<DayExpense> expenseBox = Hive.box<DayExpense>('expense');
  final Box<FilterData> filterBox = Hive.box<FilterData>('filter');

  ExpenseRepository() {
    _init();
  }

  void _init() {
    if (filterBox.get(FilterType.category.name) == null) {
      List<String> categorys = ['취미/여가', '음식', '교통비', '숙박'];
      final FilterData categoryList =
          FilterData(key: FilterType.category.name, dataList: categorys);
      filterBox.put(FilterType.category.name, categoryList);
    }

    if (filterBox.get(FilterType.label.name) == null) {
      List<String> labels = ['A', 'B', 'C', 'D'];
      final FilterData labelList =
          FilterData(key: FilterType.label.name, dataList: labels);
      filterBox.put(FilterType.label.name, labelList);
    }
  }

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

  Future<void> createCateroy(FilterType kind, String category) async {
    final FilterData? categoryList = filterBox.get(kind.name);
    if (categoryList != null) {
      categoryList.dataList.add(category);
      await filterBox.put(kind.name, categoryList);
    } else {
      final FilterData categoryList =
          FilterData(key: kind.name, dataList: [category]);
      await filterBox.put(kind.name, categoryList);
    }
  }

  Future<void> updateCategory(
      FilterType kind, String oldCategory, String newCategory) async {
    final FilterData? categoryList = filterBox.get(kind.name);
    if (categoryList != null) {
      final int index = categoryList.dataList
          .indexWhere((category) => oldCategory == category);
      if (index != -1) {
        categoryList.dataList[index] = newCategory;
        await filterBox.put(kind.name, categoryList);
      }
    }
  }

  Future<void> deleteCategory(FilterType kind, String deleteCategory) async {
    final FilterData? categoryList = filterBox.get(kind.name);
    if (categoryList != null) {
      categoryList.dataList
          .removeWhere((category) => deleteCategory == category);
      await filterBox.put(kind.name, categoryList);
    }
  }

  List<String> getAllCategory(FilterType kind) {
    final FilterData? category = filterBox.get(kind.name);
    return category?.dataList ?? [];
  }

  List<Expense> getExpensesByDate(DateTime date) {
    final int key = dateTimeToUnixTimestamp(date);
    final DayExpense? dayExpense = expenseBox.get(key);
    return dayExpense?.expenseList ?? [];
  }

  int dateTimeToUnixTimestamp(DateTime dateTime) {
    return dateTime.withoutTime.millisecondsSinceEpoch ~/ 1000;
  }
}
