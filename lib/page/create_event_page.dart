import 'package:devu_app/EventRepository.dart';
import 'package:devu_app/event.dart';
import 'package:devu_app/widget/event_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatelessWidget {
  final Event? event;
  final DateTime date;
  final void Function(Event)? onEventAdd;
  final void Function()? onEventRemove;

  const CreateEventPage(
      {super.key,
      this.event,
      required this.date,
      this.onEventAdd,
      this.onEventRemove});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<EventRepository>(context);
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
                  repository.updateEvent(date, event!.id, newEvent);
                } else {
                  repository.createEvent(date, newEvent);
                }
                Navigator.of(context).pop(true);
              },
              onEventRemove: () async {
                if (event == null) {
                  return;
                }
                repository.deleteEvent(date, event!.id);
                Navigator.of(context).pop(true);
              }),
        ),
      ),
    );
  }
}
