import 'package:devu_app/widget/test.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
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
                TestWidget(),
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
              onPressed: routeSettingPage,
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
