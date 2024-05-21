import 'package:devu_app/data/model/asset.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';

class AssetDetailCard extends StatelessWidget {
  Asset asset;
  List<Color> gradientColors = [secondaryColor, primary200Color];

  AssetDetailCard(this.asset);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '500만원',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                LabelWidget(
                  "7%",
                  Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < asset.tagList.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: LabelWidget(
                        asset.tagList[i].name,
                        Color(asset.tagList[i].color),
                        foregroundColor: getTextColorForBackground(
                            Color(asset.tagList[i].color)),
                      ),
                    )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            '현재 자산',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: IconButton.filled(
                            padding: EdgeInsets.all(0.0),
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_outlined,
                            ),
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.green),
                            iconSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    totalMoeny().toPriceString(),
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(asset.memo),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          colors: gradientColors,
                          stops: [
                            totalPersent() / 100,
                            totalPersent() / 100,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text("${totalPersent()}%"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: secondaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'D - ${dDay()}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 32),
                  child: Center(
                    child: Text(
                      '이 속도면 250일 안에 달성하겠어요\n매일 13,000원이 필요해요',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int totalMoeny() {
    return asset.incomeList
        .fold(0, (previousValue, element) => previousValue + element.value);
  }

  int totalPersent() {
    final goalMoney = asset.goalMoney;
    final totalIncome = asset.incomeList
        .fold(0, (previousValue, element) => previousValue + element.value);
    if (totalIncome == 0) {
      return 0;
    }
    final goalPersent = (goalMoney / totalIncome) * 100;
    return goalPersent.round() ~/ 100;
  }

  int dDay() {
    final endDate = unixTimestampToDateTime(asset.goalTimestamp);
    return endDate.getDayDifference(DateTime.now());
  }
}
