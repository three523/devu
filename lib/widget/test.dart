import 'package:devu_app/widget/year_month_picker.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class TestWidget extends StatefulWidget {
  DateTime currentDate = DateTime.now();

  TestWidget({super.key});
  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
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
      ),
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
