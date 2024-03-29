import 'package:calendar_view/calendar_view.dart';
import 'package:devu/extension.dart';
import 'package:devu/page/dayEventListPage.dart';
import 'package:flutter/material.dart';

class MonthViewWidget extends StatelessWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;

  const MonthViewWidget({
    super.key,
    this.state,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return MonthView(
      key: state,
      width: width,
      onCellTap: (events, date) {
        context.pushRoute(DayEventListPage(
          events: events,
          date: date,
        ));
      },
    );
  }
}
/*

*/
