import 'package:devu_app/data/model/expense_category.dart';
import 'package:hive/hive.dart';

part 'expense_category_list.g.dart';

@HiveType(typeId: 6)
class ExpenseCategoryList {
  ExpenseCategoryList(
    this.timeStamp,
    this.categoryList,
  );

  @HiveField(0)
  int timeStamp;

  @HiveField(1)
  List<ExpenseCategory> categoryList;

  @override
  String toString() => '{id: $timeStamp, categoryList: $categoryList}';
}
