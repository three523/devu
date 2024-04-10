import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _expenseRepository;
  ExpenseBloc(this._expenseRepository)
      : super(ExpenseInitState(
            _expenseRepository.getExpensesByDate(DateTime.now()))) {
    on<LoadExpenseEvent>(
      (event, emit) {
        emit(ExpenseLoadingState());

        // final expensesList = _expenseRepository.getAllExpenses();
        // emit(ExpenseSucessState(expensesList));
      },
    );
    on<LoadByDayExpenseEvent>(
      (event, emit) {
        final expenseList = _expenseRepository.getExpensesByDate(event.time);
        print("test: ${expenseList}");
        emit(ExpenseSucessState(expenseList));
      },
    );
    on<CreateExpenseEvent>(
      (event, emit) async {
        await _expenseRepository.createExpense(event.time, event.expense);
        final expenseList = _expenseRepository.getExpensesByDate(event.time);
        emit(ExpenseSucessState(expenseList));
      },
    );
  }
}
