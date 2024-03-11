import 'package:calendar_view/calendar_view.dart';
import 'package:devu/domain/event_repository.dart';
import 'package:devu/extension.dart';
import 'package:devu/widget/event_form.dart';
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
      appBar: AppBar(
          title: event == null ? const Text('새로운 예산') : const Text("현재 예산")),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: EventForm(
              event: event,
              date: date,
              onEventAdd: (newEvent) async {
                if (event != null) {
                  CalendarControllerProvider.of(context)
                      .controller
                      .update(event!, newEvent);
                  await EventRepository.updateEvent(newEvent.toEvent());
                } else {
                  CalendarControllerProvider.of(context)
                      .controller
                      .add(newEvent);
                  await EventRepository.createEvent(newEvent.toEvent());
                }
                onEventAdd?.call(newEvent);
                context.pop(true);
              },
              onEventRemove: () async {
                if (event == null) {
                  return;
                }
                CalendarControllerProvider.of(context)
                    .controller
                    .remove(event!);
                onEventRemove?.call();
                await EventRepository.removeEvent(event!.toEvent());
                context.pop(true);
              }),
        ),
      ),
    );
  }
}
