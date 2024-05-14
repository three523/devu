import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository _expenseRepository;
  ExpenseBloc(this._expenseRepository)
      : super(ExpenseInitState(
            _expenseRepository.getExpensesByDate(DateTime.now()))) {
    // on<LoadExpenseEvent>(
    //   (event, emit) {
    //     emit(ExpenseLoadingState());

    //     final expensesList = _expenseRepository.getExpensesByDate();
    //     emit(ExpenseSucessState(expensesList));
    //   },
    // );
    on<LoadByDayExpenseEvent>(
      (event, emit) {
        final expenseList = _expenseRepository.getExpensesByDate(event.time);
        emit(ExpenseSucessState(expenseList));
      },
    );
    on<CreateExpenseEvent>(
      (event, emit) async {
        final key = unixTimestampToDateTime(event.category.timeStamp);
        await _expenseRepository.createExpense(
            key, event.category, event.expense);
        final expenseList = _expenseRepository.getExpensesByDate(key);
        emit(ExpenseSucessState(expenseList));
      },
    );
    on<CreateCategoryEvent>((event, emit) async {
      final key = unixTimestampToDateTime(event.category.timeStamp);
      await _expenseRepository.createCateroy(event.date, event.category);
      final expenseList = _expenseRepository.getExpensesByDate(key);
      emit(ExpenseSucessState(expenseList));
    });
    on<DeleteCategoryEvent>(
      (event, emit) async {
        await _expenseRepository.deleteCategory(event.date, event.category);
        final expenseList = _expenseRepository.getExpensesByDate(event.date);
        emit(ExpenseSucessState(expenseList));
      },
    );
    on<UpdateCategoryEvent>(
      (event, emit) async {
        final date = unixTimestampToDateTime(event.category.timeStamp);
        await _expenseRepository.updateCategory(date, event.category);
        final expenseList = _expenseRepository.getExpensesByDate(date);
        emit(ExpenseSucessState(expenseList));
      },
    );
  }
}
