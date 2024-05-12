import 'dart:ffi';

import 'package:devu_app/data/model/asset_category.dart';
import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/data/model/filter_data.dart';
import 'package:devu_app/data/model/day_expense.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/asset_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum FilterType { category, label }

class ExpenseRepository {
  final Box<AssetCategory> assetBox = Hive.box<AssetCategory>('AssetCategory');
  final Box<ExpenseCategoryList> expenseBox =
      Hive.box<ExpenseCategoryList>('ExpenseCategory');
  final Box<Tag> tagBox = Hive.box<Tag>('Tag');

  ExpenseRepository() {
    _init();
  }

  void _init() {
    if (tagBox.keys.isEmpty) {
      Map<String, Tag> tagList = {
        '충동구매': Tag('충동구매', Colors.red.value),
        '고정수입': Tag('고정수입', Colors.green.value),
        '예금': Tag('저축', Colors.blue.value),
      };
      tagBox.putAll(tagList);
    }
  }

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
      print(
          'delete category:${deleteCategory.title} ${categoryList.categoryList.length}');
      for (int i = 0; i < categoryList.categoryList.length; i++) {
        print('uuid: ${categoryList.categoryList[i].id}');
      }
      categoryList.categoryList
          .removeWhere((category) => deleteCategory.id == category.id);
      print(
          'after :${deleteCategory.title} ${categoryList.categoryList.length}');
      await expenseBox.put(key, categoryList);
    }
  }

  List<ExpenseCategoryList> getAllCategory() {
    final List<ExpenseCategoryList> categoryList = expenseBox.values.toList();
    return categoryList;
  }

  ExpenseCategoryList getExpensesByDate(DateTime date) {
    final DateTime firstDayOfMonth = getFirstDayOfMonth(date);
    final int key = dateTimeToUnixTimestamp(firstDayOfMonth);
    final ExpenseCategoryList? categoryList = expenseBox.get(key);
    return categoryList ?? ExpenseCategoryList(key, []);
  }

  DateTime getFirstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month);
  }

  // int dateTimeToUnixTimestamp(DateTime dateTime) {
  //   return dateTime.withoutTime.millisecondsSinceEpoch ~/ 1000;
  // }

  // DateTime unixTimestampToDateTime(int timestamp) {
  //   return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  // }
}
