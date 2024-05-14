import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  Money money;

  IncomeCard(this.money);

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
              crossAxisAlignment: money.tagList.isEmpty
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isExpense(money.value)
                      ? Icons.south_east_sharp
                      : Icons.north_west_sharp,
                  size: 16,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          money.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                              leadingDistribution:
                                  TextLeadingDistribution.even),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  '${isExpense(money.value) ? '' : '+'}${(-money.value).toPriceString()}원',
                  style: TextStyle(
                      color: isExpense(money.value) ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            // if (money.tagList.isNotEmpty)
            //   Row(
            //     children: [
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Expanded(
            //         child: SizedBox(
            //           height: 26,
            //           child: ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: money.tagList.length,
            //               scrollDirection: Axis.horizontal,
            //               itemBuilder: ((context, index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.only(right: 4.0),
            //                   child: LabelWidget(money.tagList[index].name,
            //                       Color(money.tagList[index].color)),
            //                 );
            //               })),
            //         ),
            //       ),
            //     ],
            //   )
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    for (int i = 0; i < money.tagList.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: LabelWidget(money.tagList[i].name,
                            Color(money.tagList[i].color)),
                      ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 26,
            //   width: double.infinity,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       SizedBox(
            //         width: 20.0,
            //       ),
            //       for (int i = 0; i < money.tagList.length; i++)
            //         Padding(
            //           padding: const EdgeInsets.only(right: 4.0),
            //           child: LabelWidget(money.tagList[i].name,
            //               Color(money.tagList[i].color)),
            //         ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  bool isExpense(int money) {
    print(this.money.tagList);
    return money >= 0;
  }
}
