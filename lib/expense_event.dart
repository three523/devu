import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/money.dart';

sealed class ExpenseEvent {}

final class LoadExpenseEvent extends ExpenseEvent {}

final class LoadByDayExpenseCategoryListEvent extends ExpenseEvent {
  final DateTime time;
  LoadByDayExpenseCategoryListEvent(this.time);
}

final class LoadByDayExpenseCategoryEvent extends ExpenseEvent {
  final DateTime time;
  final String categoryId;
  LoadByDayExpenseCategoryEvent(this.time, this.categoryId);
}

final class CreateExpenseEvent extends ExpenseEvent {
  final ExpenseCategory category;
  final Money expense;
  CreateExpenseEvent(this.category, this.expense);
}

final class CreateCategoryEvent extends ExpenseEvent {
  final DateTime date;
  final ExpenseCategory category;
  CreateCategoryEvent(this.date, this.category);
}

final class UpdateCategoryEvent extends ExpenseEvent {
  final ExpenseCategory category;
  UpdateCategoryEvent(this.category);
}

final class DeleteCategoryEvent extends ExpenseEvent {
  final DateTime date;
  final ExpenseCategory category;
  DeleteCategoryEvent(this.date, this.category);
}
