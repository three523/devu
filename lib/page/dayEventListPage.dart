import 'package:devu/extension.dart';
import 'package:devu/page/createEventPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/widgets.dart';

class DayEventListPage extends StatefulWidget {
  final List<CalendarEventData> events;
  final DateTime date;

  const DayEventListPage({super.key, required this.events, required this.date});

  @override
  State<DayEventListPage> createState() => _DayEventListPageState();
}

class _DayEventListPageState extends State<DayEventListPage> {
  late List<CalendarEventData> _events;

  @override
  void initState() {
    super.initState();
    _events = List<CalendarEventData>.from(widget.events);
  }

  @override
  Widget build(BuildContext context) {
    int income = getIncome();
    int expenses = getExpenses();
    int totalPrice = income - expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.date.formattedDay} 기록'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(CreateEventPage(
            date: widget.date,
            onEventAdd: (newEvent) {
              setState(() {
                _events.add(newEvent);
              });
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: ((context, index) {
                    CalendarEventData event = _events[index];
                    return OutlinedButton(
                        onPressed: () {
                          context.pushRoute(CreateEventPage(
                            event: event,
                            date: widget.date,
                            onEventAdd: (newEvent) {
                              setState(() {
                                _events[index] = newEvent;
                              });
                            },
                            onEventRemove: () {
                              setState(() {
                                _events.removeAt(index);
                              });
                            },
                          ));
                        },
                        child: Text(
                          event.price.toString(),
                          style: TextStyle(
                              color: event.type == EventType.income
                                  ? Colors.blue
                                  : Colors.red),
                        ));
                  })),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    '수입: ${income.toPriceString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  )),
                  Expanded(
                      child: Text(
                    '지출: ${expenses.toPriceString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Text(
                '총 금액: ${totalPrice.toPriceString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: totalPrice >= 0 ? Colors.blue : Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  int getIncome() {
    return _events.fold(0, (previousValue, element) {
      if (element.type == EventType.income) {
        return previousValue + element.price;
      }
      return previousValue;
    });
  }

  int getExpenses() {
    return _events.fold(0, (previousValue, element) {
      if (element.type == EventType.expenses) {
        return previousValue + element.price;
      }
      return previousValue;
    });
  }
}
