import 'dart:ui';

import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage();

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  List<String> categoryItemList = ['교통비', '식비', '용돈'];
  List<Color> categoryColorList = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
  ];
  Color isSelectedColor = Colors.redAccent;
  TextEditingController textEditingController = TextEditingController();
  int price = 0;
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
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categoryItemList.length + 2,
            itemBuilder: (context, index) {
              return getListViewItem(index);
            }),
      ),
    );
  }

  Widget getListViewItem(int index) {
    print(index);
    if (index == 0) {
      return getHeaderView();
    } else if (index == categoryItemList.length + 1) {
      return getAddCategoryButton();
    } else {
      return getCategoryCard(index - 1);
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
        child: GestureDetector(
          onTap: showAddCategoryDialog,
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
      ),
    );
  }

  void showAddCategoryDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: Text('카테고리를 만들어주세요'),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: '카테고리 이름을 입력해주세요'),
                  ),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < categoryColorList.length; i++)
                          categoryColor(i, setState)
                      ],
                    ),
                  );
                }),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty == false) {
                      setState(() {
                        categoryItemList.add(textEditingController.text);
                      });
                      Navigator.pop(context);
                    } else {
                      print('카테고리를 입력해주어야합니다.');
                    }
                  },
                  child: Text('확인')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('취소')),
            ],
          );
        });
  }

  Widget getCategoryCard(int index) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200, minHeight: 140),
            child: CategoryCard(0,
                cardType: CardType.input,
                categoryName: categoryItemList[index],
                updatePrice: updateTotalPrice),
          ),
        ),
        SizedBox(
          width: 30.0,
          height: 30.0,
          child: IconButton.outlined(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              removeCategory(index);
            },
            color: Colors.black,
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }

  Widget categoryColor(int index, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelectedColor = categoryColorList[index];
          });
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: isSelectedColor == categoryColorList[index]
                ? Border.all(
                    color: Colors.black,
                    width: 1,
                  )
                : null,
            borderRadius: BorderRadius.circular(15),
            color: categoryColorList[index],
          ),
        ),
      ),
    );
  }

  void updateTotalPrice(int addPrice) {
    setState(() {
      price += addPrice;
    });
  }

  void removeCategory(int index) {
    setState(() {
      categoryItemList.removeAt(index);
    });
  }
}
