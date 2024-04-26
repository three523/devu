import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCategory extends StatefulWidget {
  AddCategory();

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  int price = 0;
  int count = 2;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('지출 예산 설정하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: count + 2,
                  itemBuilder: (context, index) {
                    return getListViewItem(index);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget getListViewItem(int index) {
    if (index == 0) {
      return getHeaderView();
    } else if (index == count + 1) {
      return getAddCategoryButton();
    } else {
      return getCategoryCard();
    }
  }

  Column getHeaderView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('2024.5월 총 예산'),
        Container(
          width: double.infinity,
          child: Text(
            price.toPriceString(),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  ConstrainedBox getAddCategoryButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180, minHeight: 140),
      child: Card(
        child: DottedBorder(
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: Radius.circular(16),
          strokeCap: StrokeCap.square,
          dashPattern: [4],
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(size: 60.0, Icons.add),
                Text('카테고리 추가하기'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ConstrainedBox getCategoryCard() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180, minHeight: 140),
      child: CategoryCard(0, CardType.input),
    );
  }
}
