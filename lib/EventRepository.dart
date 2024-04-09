import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'event.dart';

class EventRepository {
  final Box<Map<DateTime, List<Event>>> _eventBox = Hive.box('events');

  // Future<void> initEventBox() async {
  //   _eventBox = await Hive.openBox<Map<DateTime, List<Event>>>('events');
  // }

  Future<void> createEvent(DateTime key, Event newEvent) async {
    var eventsMap = _eventBox.get(key) ?? <DateTime, List<Event>>{};
    eventsMap[key] = [...?eventsMap[key], newEvent];
    await _eventBox.put(key, eventsMap);
  }

  Future<void> updateEvent(DateTime key, String id, Event updatedEvent) async {
    var eventsMap = _eventBox.get(key) ?? <DateTime, List<Event>>{};
    var events = eventsMap[key] ?? [];
    final index = events.indexWhere((event) => event.id == id);
    if (index != -1) {
      events[index] = updatedEvent;
      eventsMap[key] = events;
      await _eventBox.put(key, eventsMap);
    }
  }

  Future<void> deleteEvent(DateTime key, String id) async {
    var eventsMap = _eventBox.get(key) ?? <DateTime, List<Event>>{};
    var events = eventsMap[key] ?? [];
    events.removeWhere((event) => event.id == id);
    eventsMap[key] = events;
    await _eventBox.put(key, eventsMap);
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

  List<Event> getEventsByDate(DateTime key) {
    var eventsMap = _eventBox.get(key) ?? <DateTime, List<Event>>{};
    return eventsMap[key] ?? [];
  }

  Event? getEventById(DateTime key, String id) {
    var eventsMap = _eventBox.get(key) ?? <DateTime, List<Event>>{};
    var allEvents = eventsMap.values.expand((events) => events).toList();
    return allEvents.firstWhereOrNull((event) => event.id == id);
  }
}
