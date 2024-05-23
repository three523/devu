import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetailBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _expenseRepository;
  ExpenseDetailBloc(this._expenseRepository)
      : super(ExpenseInitState(
            _expenseRepository.getExpensesByDate(DateTime.now()))) {
    on<LoadByDayExpenseCategoryEvent>(
      (event, emit) {
        final category =
            _expenseRepository.getExpenseByDate(event.time, event.categoryId);
        emit(ExpenseCategorySucessState(category));
      },
    );
  }
}
