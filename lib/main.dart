import 'dart:ui';
import 'package:devu/widget/monthViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:hive/hive.dart';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController()..addAll(_events),
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

DateTime get _now => DateTime.now();
List<CalendarEventData> _events = [
  CalendarEventData(
    date: _now,
    price: 8000,
    type: EventType.expenses,
    description: "Today is project meeting.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    price: 10000,
    type: EventType.expenses,
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    price: 6000,
    type: EventType.income,
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    price: 6000,
    type: EventType.income,
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    price: 6000,
    type: EventType.income,
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    price: 15000,
    type: EventType.income,
    description: "Today is Joe's birthday.",
  ),
];
