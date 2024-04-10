import 'package:devu_app/data/model/expense.dart';

sealed class ExpenseEvent {}

final class LoadExpenseEvent extends ExpenseEvent {}

final class LoadByDayExpenseEvent extends ExpenseEvent {
  final DateTime time;
  LoadByDayExpenseEvent(this.time);
}

final class CreateExpenseEvent extends ExpenseEvent {
  final DateTime time;
  final Expense expense;
  CreateExpenseEvent(this.time, this.expense);
}
