import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/money.dart';
import 'package:devu_app/data/model/tag.dart';
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
                      Text(money.title),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 26,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < money.tagList.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: LabelWidget(money.tagList[i].name,
                                    Color(money.tagList[i].color)),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Text('${-money.value}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
