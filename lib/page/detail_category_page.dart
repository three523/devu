import 'package:devu_app/widget/category_card.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:devu_app/widget/date_swipe_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('카테고리 상세'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DateSwipeWidget(),
          Container(
            width: double.infinity,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: CategoryCard(
                  30.0,
                  categoryName: '식비',
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                padding: EdgeInsetsDirectional.symmetric(vertical: 12.0),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return IncomeCard();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 12,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
