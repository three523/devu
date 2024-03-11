import 'dart:ui';
import 'package:devu/domain/event.dart';
import 'package:devu/domain/event_repository.dart';
import 'package:devu/widget/month_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  await EventRepository.openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<CalendarEventData> events =
        EventRepository.getAll().map((e) => e.toCalendarEventData()).toList();
    return CalendarControllerProvider(
      controller: EventController()..addAll(events),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          scrollBehavior: ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          home: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     context.pushRoute(CreateEventPage());
      //   },
      // ),
      body: MonthViewWidget(),
    );
  }
}
