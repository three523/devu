import 'package:devu_app/data/model/expense.dart';

sealed class ExpenseState {}

class ExpenseInitState extends ExpenseState {
  final List<Expense> eventModel;
  ExpenseInitState(this.eventModel);
}

class ExpenseSucessState extends ExpenseState {
  final List<Expense> eventModel;
  ExpenseSucessState(this.eventModel);
}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseErrorState extends ExpenseState {
  final String error;
  ExpenseErrorState(this.error);
}
