import 'dart:ffi';

import 'package:devu_app/data/model/asset_category.dart';
import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

enum FilterType { category, label }

class ExpenseRepository {
  final Box<AssetCategory> assetBox = Hive.box<AssetCategory>('AssetCategory');
  final Box<ExpenseCategoryList> expenseBox =
      Hive.box<ExpenseCategoryList>('ExpenseCategory');

  ExpenseRepository();

  Future<void> createExpense(
      DateTime date, ExpenseCategory category, Money newExpense) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? dayCategoryList = expenseBox.get(key);

    if (dayCategoryList != null) {
      final int categoryIndex = dayCategoryList.categoryList
          .indexWhere((element) => element.id == category.id);
      if (categoryIndex != -1) {
        dayCategoryList.categoryList[categoryIndex].expenseList.add(newExpense);
        await expenseBox.put(key, dayCategoryList);
      }
    } else {
      await createCateroy(date, category);
    }
  }

  Future<void> updateExpense(
      DateTime date, String id, Money updatedExpense) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? dayCategoryList = expenseBox.get(key);

    if (dayCategoryList != null) {
      final int index = dayCategoryList.categoryList
          .indexWhere((expense) => expense.id == id);
      if (index != -1) {
        final int moneyIndex = dayCategoryList.categoryList[index].expenseList
            .indexWhere((element) => element.id == updatedExpense.id);
        if (moneyIndex != -1) {
          dayCategoryList.categoryList[index].expenseList[moneyIndex] =
              updatedExpense;
          await expenseBox.put(key, dayCategoryList);
        }
      }
    }
  }

  Future<void> deleteExpense(
      DateTime date, String categoryId, String expenseId) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? dayCategoryList = expenseBox.get(key);
    if (dayCategoryList != null) {
      final categoryIndex = dayCategoryList.categoryList
          .indexWhere((element) => element.id == categoryId);
      if (categoryIndex != -1) {
        dayCategoryList.categoryList[categoryIndex].expenseList
            .removeWhere((element) => element.id == expenseId);
        await expenseBox.put(key, dayCategoryList);
      }
    }
  }

  Future<void> createCateroy(DateTime date, ExpenseCategory category) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    ExpenseCategoryList? dayCategoryList = expenseBox.get(key);
    if (dayCategoryList != null) {
      dayCategoryList.categoryList.add(category);
    } else {
      dayCategoryList = ExpenseCategoryList(key, [category]);
    }
    await expenseBox.put(key, dayCategoryList);
  }

  Future<void> updateCategory(
      DateTime date, ExpenseCategory newCategory) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? categoryList = expenseBox.get(key);
    if (categoryList != null) {
      final int index = categoryList.categoryList
          .indexWhere((category) => newCategory.id == category.id);
      if (index != -1) {
        categoryList.categoryList[index] = newCategory;
        await expenseBox.put(key, categoryList);
      }
    }
  }

  Future<void> deleteCategory(
      DateTime date, ExpenseCategory deleteCategory) async {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? categoryList = expenseBox.get(key);
    if (categoryList != null) {
      categoryList.categoryList
          .removeWhere((category) => deleteCategory.id == category.id);
      await expenseBox.put(key, categoryList);
    }
  }

  List<ExpenseCategoryList> getAllCategory() {
    final List<ExpenseCategoryList> categoryList = expenseBox.values.toList();
    return categoryList;
  }

  List<dynamic> getAllCategoryKey() {
    return expenseBox.keys.toList();
  }

  ExpenseCategoryList getExpensesByDate(DateTime date) {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? categoryList = expenseBox.get(key);
    if (categoryList == null) {
      final allCategoryKey = getAllCategoryKey();
      if (allCategoryKey.isEmpty) {
        return ExpenseCategoryList(key, []);
      }
      allCategoryKey.sort((a, b) {
        if (a is int && b is int) {
          if (a <= b) {
            return -1;
          } else {
            return 1;
          }
        } else {
          return -1;
        }
      });
      final previousCategoryList = expenseBox.get(allCategoryKey.last);
      if (previousCategoryList != null &&
          previousCategoryList.categoryList.isNotEmpty) {
        ExpenseCategoryList newCategoryList;
        newCategoryList = copyCategoryList(
            firstDayOfMonth, previousCategoryList.categoryList);
        createCategoryList(newCategoryList);
        return newCategoryList;
      }
    }

    return categoryList ?? ExpenseCategoryList(key, []);
  }

  void createCategoryList(ExpenseCategoryList categoryList) {
    final DateTime date = unixTimestampToDateTime(categoryList.timeStamp);
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    expenseBox.put(key, categoryList);
  }

  // expenseList, id 만 새롭게 생성
  ExpenseCategoryList copyCategoryList(
      DateTime date, List<ExpenseCategory> categoryList) {
    ExpenseCategoryList newCategoryList =
        ExpenseCategoryList(dateTimeToUnixTimestamp(date), []);
    for (int i = 0; i < categoryList.length; i++) {
      ExpenseCategory newCategory = categoryList[i].copyWith(
          id: Uuid().v4(),
          timeStamp: dateTimeToUnixTimestamp(date),
          expenseList: []);
      newCategoryList.categoryList.add(newCategory);
    }
    return newCategoryList;
  }

  DateTime getFirstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month);
  }
}
