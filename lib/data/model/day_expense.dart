import 'package:devu_app/data/model/expense.dart';
import 'package:hive/hive.dart';

part 'day_expense.g.dart';

@HiveType(typeId: 1)
class DayExpense {
  DayExpense({
    required this.timeStamp,
    required this.expenseList,
  });

  @HiveField(0)
  int timeStamp;

  @HiveField(1)
  List<Expense> expenseList;

  @override
  String toString() => '{timeStamp: $timeStamp, expenseList: $expenseList}';
}
