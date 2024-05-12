import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/data/model/money.dart';

sealed class ExpenseState {}

class ExpenseInitState extends ExpenseState {
  final ExpenseCategoryList eventModel;
  ExpenseInitState(this.eventModel);
}

class ExpenseSucessState extends ExpenseState {
  final ExpenseCategoryList eventModel;
  ExpenseSucessState(this.eventModel);
}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseErrorState extends ExpenseState {
  final String error;
  ExpenseErrorState(this.error);
}
