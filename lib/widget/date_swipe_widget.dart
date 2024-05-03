import 'package:devu_app/widget/year_month_picker.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateSwipeWidget extends StatefulWidget {
  DateTime currentDate = DateTime.now();
  MainAxisAlignment alignment;

  DateSwipeWidget({MainAxisAlignment? alignment})
      : alignment = alignment ?? MainAxisAlignment.start;
  @override
  State<DateSwipeWidget> createState() => _DateSwipeWidgetState();
}

class _DateSwipeWidgetState extends State<DateSwipeWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: previousMonth, icon: const Icon(Icons.arrow_back_ios)),
        TextButton(
            onPressed: showDatePicker,
            child: Text(
                "${widget.currentDate.year}년 ${widget.currentDate.month}월")),
        IconButton(
            onPressed: nextMonth, icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }

  void previousMonth() {
    setState(() {
      final tempCurrentDate = widget.currentDate;
      widget.currentDate =
          DateTime(tempCurrentDate.year, tempCurrentDate.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      final tempCurrentDate = widget.currentDate;
      widget.currentDate =
          DateTime(tempCurrentDate.year, tempCurrentDate.month + 1);
    });
  }

  void showDatePicker() {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          widget.currentDate = DateTime(date.year, date.month);
        });
      }
    });
  }
}
