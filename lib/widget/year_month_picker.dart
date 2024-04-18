import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  MonthPicker(
      {required this.initialYear,
      required this.startYear,
      required this.endYear,
      this.currentYear,
      required this.month,
      super.key});
  late int initialYear;
  late int startYear;
  late int endYear;
  late int? currentYear;
  late int month;
  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  final List<String> _monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> _yearList = [];
  late int selectedMonthIndex;
  late int selectedYearIndex;
  String selectedMonth = "";
  String selectedYear = "";
  @override
  void initState() {
    for (int i = widget.startYear; i <= widget.endYear; i++) {
      _yearList.add(i.toString());
    }
    selectedMonthIndex = widget.month - 1;
    selectedYearIndex = _yearList.indexOf(
        widget.currentYear?.toString() ?? widget.initialYear.toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedMonth = _monthList[selectedMonthIndex];
        selectedYear = _yearList[selectedYearIndex];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pick a date",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DropdownButton<String>(
                  underline: Container(),
                  items: _monthList.map((e) {
                    return DropdownMenuItem<String>(value: e, child: Text(e));
                  }).toList(),
                  value: selectedMonth,
                  onChanged: (val) {
                    setState(() {
                      selectedMonthIndex = _monthList.indexOf(val!);
                      selectedMonth = val ?? "";
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: DropdownButton<String>(
                  underline: Container(),
                  items: _yearList.map((e) {
                    return DropdownMenuItem<String>(value: e, child: Text(e));
                  }).toList(),
                  value: selectedYear,
                  onChanged: (val) {
                    setState(() {
                      selectedYear = val ?? "";
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    // save your value
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Text(
                    "OK",
                  ))
            ],
          )
        ],
      ),
    );
  }
}
