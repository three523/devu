import 'package:calendar_view/calendar_view.dart';
import 'package:devu/extension.dart';
import 'package:devu/widget/eventForm.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatelessWidget {
  final CalendarEventData? event;
  final DateTime date;
  final void Function(CalendarEventData)? onEventAdd;
  final void Function()? onEventRemove;

  const CreateEventPage(
      {super.key,
      this.event,
      required this.date,
      this.onEventAdd,
      this.onEventRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: event == null ? Text('새로운 예산') : Text("현재 예산")),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: EventForm(
            event: event,
            date: date,
            onEventAdd: (newEvent) {
              if (event != null) {
                CalendarControllerProvider.of(context)
                    .controller
                    .update(event!, newEvent);
              } else {
                CalendarControllerProvider.of(context).controller.add(newEvent);
              }
              onEventAdd?.call(newEvent);
              context.pop(true);
            },
            onEventRemove: () {
              if (event == null) {
                return;
              }
              CalendarControllerProvider.of(context).controller.remove(event!);
              onEventRemove?.call();
              context.pop(true);
            },
          ),
        ),
      ),
    );
  }
}
