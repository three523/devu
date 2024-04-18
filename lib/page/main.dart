import 'package:devu_app/data/model/filter_data.dart';
import 'package:devu_app/data/model/day_expense.dart';
import 'package:devu_app/data/model/expense.dart';
import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:devu_app/page/create_event_page.dart';
import 'package:devu_app/page/main_page.dart';
import 'package:devu_app/page/navigationbar_page.dart';
import 'package:devu_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DayExpenseAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(FilterDataAdapter());
  // await Hive.deleteBoxFromDisk('expense');
  await Hive.openBox<DayExpense>('expense');
  await Hive.openBox<FilterData>('filter');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: CalendartPage(ExpenseRepository()));
        home: NavigationBarPage());
  }
}

class CalendartPage extends StatefulWidget {
  final ExpenseRepository repository;
  CalendartPage(this.repository);
  @override
  _CalendartPageState createState() => _CalendartPageState();
}

class _CalendartPageState extends State<CalendartPage> {
  late final ValueNotifier<List<Expense>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Expense> _getEventsForDay(DateTime day) {
    // Implementation example
    return widget.repository.getExpensesByDate(day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void updateUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventPage(
                repository: widget.repository,
                date: _selectedDay ?? DateTime.now(),
                onEventAdd: updateUI,
                onEventDelete: updateUI,
                onEventUpdate: updateUI,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar<Expense>(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Expense>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateEventPage(
                                repository: widget.repository,
                                date: _selectedDay ?? DateTime.now(),
                                event: value[index],
                                onEventAdd: updateUI,
                                onEventDelete: updateUI,
                                onEventUpdate: updateUI,
                              ),
                            ),
                          );
                        },
                        title: Text('${value[index].price}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
