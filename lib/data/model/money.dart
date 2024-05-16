import 'package:devu_app/data/model/tag.dart';
import 'package:hive/hive.dart';

part 'money.g.dart';

@HiveType(typeId: 0)
class Money {
  Money(
    this.id,
    this.title,
    this.categoryId,
    this.date,
    this.value,
    this.tagList,
  );

  Money copyWith(
          {String? id,
          String? title,
          String? categoryId,
          DateTime? date,
          int? value,
          List<Tag>? tagList}) =>
      Money(id ?? this.id, title ?? this.title, categoryId ?? this.categoryId,
          date ?? this.date, value ?? this.value, tagList ?? this.tagList);

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

  @override
  String toString() =>
      '{id: $id, title: $title, categoryId: $categoryId, date: $date, value: $value, tagList: $tagList}';
}
