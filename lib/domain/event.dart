import 'package:calendar_view/calendar_view.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event {
  Event(
      {required this.id,
      required this.price,
      required this.date,
      required this.type});

  @HiveField(0)
  String id;

  @HiveField(1)
  int price;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String type;

  CalendarEventData toCalendarEventData() {
    return CalendarEventData(
        id: id, price: price, date: date, type: type.parseToEventType());
  }

  @override
  String toString() => '{id: $id, price: $price, date: $date, type: $type}';
}
