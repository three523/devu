import 'package:calendar_view/calendar_view.dart';
import 'package:hive/hive.dart';

class Event {
  Event({required this.price, required this.date, required this.type});

  int price;

  DateTime date;

  EventType type;

  CalendarEventData toCalendarEventData() {
    return CalendarEventData(price: price, date: date, type: type);
  }
}

class EventAdapter extends TypeAdapter<Event> {
  @override
  final typeId = 0;

  @override
  Event read(BinaryReader reader) {
    return Event(
      price: reader.readInt(),
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      type: reader.readString().parseToEventType(),
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer.writeInt(obj.price);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.type.toString());
  }
}
