import 'package:devu_app/widget/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IncomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.abc),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('4월 급여'),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 26,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Label(title: '필요함'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text('+300만원'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
