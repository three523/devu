import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  Event({
    required this.id,
    required this.price,
    required this.date,
    required this.type,
    required this.eventCategory,
    required this.labels,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  int price;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String type;

  @HiveField(4)
  String eventCategory;

  @HiveField(5, defaultValue: [])
  List<String> labels;

  @override
  String toString() =>
      '{id: $id, price: $price, date: $date, type: $type, category: $eventCategory, labels: $labels}';
}
