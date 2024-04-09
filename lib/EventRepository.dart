import 'package:devu_app/extenstion.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'event.dart';

class EventRepository {
  final Box<Map<int, List<Event>>> _eventBox = Hive.box('events');

  // Future<void> initEventBox() async {
  //   _eventBox = await Hive.openBox<Map<DateTime, List<Event>>>('events');
  // }

  Future<void> createEvent(DateTime time, Event newEvent) async {
    int key = dateTimeToUnixTimestamp(time.withoutTime);
    var eventsMap = _eventBox.get(key) ?? <int, List<Event>>{};
    eventsMap[key] = [...?eventsMap[key], newEvent];
    await _eventBox.put(key, eventsMap);
  }

  Future<void> updateEvent(DateTime time, String id, Event updatedEvent) async {
    int key = dateTimeToUnixTimestamp(time.withoutTime);
    var eventsMap = _eventBox.get(key) ?? <int, List<Event>>{};
    var events = eventsMap[key] ?? [];
    final index = events.indexWhere((event) => event.id == id);
    if (index != -1) {
      events[index] = updatedEvent;
      eventsMap[key] = events;
      await _eventBox.put(key, eventsMap);
    }
  }

  Future<void> deleteEvent(DateTime time, String id) async {
    int key = dateTimeToUnixTimestamp(time.withoutTime);
    var eventsMap = _eventBox.get(key) ?? <int, List<Event>>{};
    var events = eventsMap[time.withoutTime] ?? [];
    events.removeWhere((event) => event.id == id);
    eventsMap[key] = events;
    await _eventBox.put(time.withoutTime, eventsMap);
  }

  List<Event> getAllEvents() {
    List<Event> allEvents = [];
    _eventBox.values.forEach((eventsMap) {
      eventsMap.values.forEach((events) {
        allEvents.addAll(events);
      });
    });
    return allEvents;
  }

  List<Event> getEventsByDate(DateTime time) {
    int key = dateTimeToUnixTimestamp(time.withoutTime);
    var eventsMap = _eventBox.get(key) ?? <int, List<Event>>{};
    return eventsMap[key] ?? [];
  }

  Event? getEventById(DateTime time, String id) {
    int key = dateTimeToUnixTimestamp(time.withoutTime);
    var eventsMap = _eventBox.get(key) ?? <int, List<Event>>{};
    var allEvents = eventsMap.values.expand((events) => events).toList();
    return allEvents.firstWhereOrNull((event) => event.id == id);
  }

  int dateTimeToUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  DateTime unixTimestampToDateTime(int unixTimestamp) {
    return DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  }
}
