import 'package:calendar_view/calendar_view.dart';
import 'package:devu/extension.dart';
import 'package:devu/widget/dateTimeSelector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EventForm extends StatefulWidget {
  final void Function(CalendarEventData)? onEventAdd;
  final void Function()? onEventRemove;

  final CalendarEventData? event;
  final DateTime date;

  const EventForm({
    super.key,
    this.onEventAdd,
    this.onEventRemove,
    this.event,
    required this.date,
  });

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  late DateTime eventDate =
      widget.event == null ? widget.date : widget.event!.date.withoutTime;

  final form = GlobalKey<FormState>();

  late final titleController = TextEditingController(
      text: widget.event == null ? '0' : widget.event?.price.toString());
  late final descriptionController = TextEditingController(
      text: widget.event == null ? '' : widget.event?.description);
  late final titleNote = FocusNode();
  late final descriptionNode = FocusNode();

  String previousValue = '0';
  String currntValue = '0';

  List<bool> isSelectedButtons = [true, false];
  EventType type = EventType.income;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: '비용',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              var maxLength = 19;
              if (value == '') {
                titleController.text = '0';
                currntValue = '0';
                previousValue = '0';
                return;
              }
              if (value.length > maxLength) {
                titleController.text = previousValue;
                return;
              }

              previousValue = currntValue;
              currntValue = value.toPriceString();

              titleController.text = currntValue;
            },
            validator: (value) {
              if (value == null || value == '' || value == '0') {
                return '비용을 입력해주세요';
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 15.0),
          DateTimeSelectorFormField(
            decoration: InputDecoration(hintText: 'Date'),
            initialDateTime: eventDate,
            onSelect: (date) {
              eventDate = date.withoutTime;
            },
            validator: (value) {
              if (value == null || value == '') {
                return '날짜를 선택해주세요';
              }
              return null;
            },
            onSave: (date) => eventDate = date ?? eventDate,
            type: DateTimeSelectionType.date,
          ),
          SizedBox(height: 15.0),
          ToggleButtons(
            onPressed: (index) {
              type = index == 0 ? EventType.income : EventType.expenses;
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelectedButtons.length;
                    buttonIndex++) {
                  if (index == buttonIndex) {
                    isSelectedButtons[buttonIndex] = true;
                  } else {
                    isSelectedButtons[buttonIndex] = false;
                  }
                }
              });
            },
            children: [
              Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: Text('수입'),
              ),
              Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: Text('지출'),
              ),
            ],
            isSelected: isSelectedButtons,
            selectedColor: Colors.green,
            color: Colors.blueGrey,
            constraints: BoxConstraints(
                minWidth: (MediaQuery.of(context).size.width - 60) / 2),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: '설명'),
          ),
          Row(
            children: [
              if (widget.event != null)
                Expanded(
                  child: ElevatedButton(
                    onPressed: removeEvent,
                    child: Text('삭제하기'),
                  ),
                ),
              Expanded(
                child: ElevatedButton(
                  onPressed: createEvent,
                  child: Text(widget.event == null ? '추가하기' : '업데이트'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void createEvent() {
    if (form.currentState?.validate() == false) {
      return form.currentState?.save();
    }

    final event = CalendarEventData(
        price: titleController.text.trim().toPrice(),
        type: type,
        date: eventDate,
        description: descriptionController.text.trim(),
        color: Colors.transparent,
        titleStyle: TextStyle(
          color: type == EventType.income ? Colors.blue : Colors.red,
        ));

    widget.onEventAdd?.call(event);
  }

  void removeEvent() {
    widget.onEventRemove?.call();
  }
}
