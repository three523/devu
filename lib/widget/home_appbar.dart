import 'dart:ffi';

import 'package:devu_app/page/add_category_page.dart';
import 'package:devu_app/page/add_expenses_page.dart';
import 'package:devu_app/widget/date_swipe_widget.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  String pageName;

  HomeAppBar(this.pageName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateSwipeWidget(),
                Row(
                  children: [
                    Text(
                      '총 예산',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '420,000원',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 91, 148, 168),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.pushNamed(context, pageName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '설정하기',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void routeSettingPage() {}
}
