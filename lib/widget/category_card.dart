import 'package:devu_app/data/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        constraints: BoxConstraints(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 14, left: 12.0, right: 12.0, bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('식비'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '120,500',
                        style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '/24만',
                        style: TextStyle(fontSize: contentTextSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Spacer(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      width: double.infinity,
                      // color: primaryColor,
                      decoration: BoxDecoration(
                        color: primary200Color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text("25%"),
                ],
              ),
            ),
            Container(
              height: 52.0,
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '매일 4,000원씩 쓸 수 있어요',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
