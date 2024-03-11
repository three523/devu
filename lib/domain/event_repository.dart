import 'package:devu/domain/event.dart';
import 'package:hive/hive.dart';

class EventRepository {
  static late final Box<Event> box;

  static Future<void> openBox() async {
    box = await Hive.openBox<Event>('events');
  }

  static Future<void> createEvent(Event newEvent) async {
    await box.put(newEvent.id, newEvent);
  }

  static Future<void> updateEvent(Event newEvent) async {
    await box.put(newEvent.id, newEvent);
  }

  static Future<void> removeEvent(Event removeEvent) async {
    await box.delete(removeEvent.id);
  }

  static List<Event> getAll() {
    return box.values.toList();
  }

  static Event? get(String id) {
    return box.get(id);
  }
}
