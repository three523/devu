import 'dart:ffi';

import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/trianglePainter.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/asset_detail_card.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:devu_app/widget/number_update_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailAssetPage extends StatefulWidget {
  @override
  State<DetailAssetPage> createState() => _DetailAssetPageState();
}

enum MenuType { update, delete }

class _DetailAssetPageState extends State<DetailAssetPage> {
  List<Color> gradientColors = [primaryColor, primary200Color];
  double filePercent = 25.0;
  double triangleSize = 12.0;
  List<String> labelList = ['예금', '장기체', '미국ETF'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton(
              color: Colors.white,
              popUpAnimationStyle: AnimationStyle.noAnimation,
              onSelected: (value) {
                switch (value) {
                  case MenuType.update:
                    break;
                  case MenuType.delete:
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuType>>[
                const PopupMenuItem<MenuType>(
                  value: MenuType.update,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      Text('수정하기'),
                    ],
                  ),
                ),
                const PopupMenuItem<MenuType>(
                  value: MenuType.delete,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                      Text(
                        '삭제하기',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
              child: Icon(Icons.menu),
            ),
          ),
        ],
        title: Text('카테고리 이름'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return getHeader();
                }
                return IncomeCard();
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12,
                );
              },
            ),
          ),
          Container(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '총 수익',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              '2024.04.11 기준',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Text(
                          '45,000원',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      height: 24,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: gradientColors,
                                stops: [
                                  filePercent.round() / 100,
                                  filePercent.round() / 100,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          getTriangle(25, '3.4%', Colors.red, triangleSize),
                          getTriangle(
                              70, '7%', Colors.yellowAccent, triangleSize),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTriangle(int persent, String text, Color color, double size) {
    return Positioned(
      bottom: 5,
      left: MediaQuery.of(context).size.width * (persent / 100) - size - 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipPath(
            clipper: CustomTriangleClipper(),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
          child: AssetDetailCard(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "저축 내역",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              TextButton.icon(
                onPressed: () {
                  showAddIncomeDialog(context, setState);
                },
                icon: Text('추가하기'),
                label: Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void showAddIncomeDialog(BuildContext context, Function setState) {
    int income = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('추가할 금액을 입력해주세요.'),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('${formatToKoreanNumber(income)}원'),
                      NumberUpdateWidget(
                        10000,
                        (num) => {
                          setState(() {
                            income = num.toInt();
                          })
                        },
                        valueType: ValueType.money,
                      ),
                    ],
                  ),
                  Text('라벨을 붙여주세요'),
                  SizedBox(
                    height: 16,
                  ),
                  DropdownMenu<Text>(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: Text(''), label: labelList[0]),
                      DropdownMenuEntry(value: Text(''), label: labelList[1]),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          backgroundColor: primaryColor),
                      onPressed: () {},
                      child: Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
