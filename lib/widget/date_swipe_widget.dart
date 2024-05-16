import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/widget/year_month_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateSwipeWidget extends StatefulWidget {
  DateTime currentDate;
  MainAxisAlignment alignment;
  Function(DateTime)? onChangeDate;

  DateSwipeWidget(this.currentDate,
      {MainAxisAlignment? alignment, this.onChangeDate})
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
      if (widget.onChangeDate != null) {
        widget.onChangeDate!(widget.currentDate);
      }
    });
  }

  void nextMonth() {
    setState(() {
      final tempCurrentDate = widget.currentDate;
      if (tempCurrentDate.month == DateTime.now().month &&
          tempCurrentDate.year == DateTime.now().year) {
        return;
      }
      widget.currentDate =
          DateTime(tempCurrentDate.year, tempCurrentDate.month + 1);
      if (widget.onChangeDate != null) {
        widget.onChangeDate!(widget.currentDate);
      }
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
          if (widget.onChangeDate != null) {
            widget.onChangeDate!(widget.currentDate);
          }
        });
      }
    });
  }
}
