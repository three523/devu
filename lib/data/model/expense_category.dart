import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:hive/hive.dart';

part 'expense_category.g.dart';

@HiveType(typeId: 4)
class ExpenseCategory {
  ExpenseCategory(
    this.id,
    this.title,
    this.belowMoeny,
    this.timeStamp,
    this.expenseList,
    this.memo,
    this.tagList,
  );

  ExpenseCategory copyWith(
          {String? id,
          String? title,
          int? belowMoeny,
          int? timeStamp,
          List<Money>? expenseList,
          String? memo,
          List<Tag>? tagList}) =>
      ExpenseCategory(
          id ?? this.id,
          title ?? this.title,
          belowMoeny ?? this.belowMoeny,
          timeStamp ?? this.timeStamp,
          expenseList ?? this.expenseList,
          memo ?? this.memo,
          tagList ?? this.tagList);

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int belowMoeny;

  @HiveField(3)
  int timeStamp;

  @HiveField(4)
  List<Money> expenseList;

  @HiveField(5)
  String memo;

  @HiveField(6)
  List<Tag> tagList;

  @override
  String toString() =>
      '{id: $id, title: $title, belowMoeny: $belowMoeny, timeStamp: $timeStamp, expenseList: $expenseList, memo: $memo, tagList: $tagList}';
}
