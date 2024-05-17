import 'package:devu_app/data/model/tag.dart';
import 'package:hive/hive.dart';

part 'money.g.dart';

@HiveType(typeId: 0)
class Money {
  Money(
      this.id, this.title, this.categoryId, this.date, this.value, this.tagList,
      {bool? isInterest})
      : isInterest = isInterest ?? false;

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String categoryId;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  int value;

  @HiveField(5, defaultValue: [])
  List<Tag> tagList;

  @HiveField(6, defaultValue: false)
  bool isInterest;

  @override
  String toString() =>
      '{id: $id, title: $title, categoryId: $categoryId, date: $date, value: $value, tagList: $tagList, isInterest: $isInterest}';
}
