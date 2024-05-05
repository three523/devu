import 'package:devu_app/data/resource.dart';
import 'package:devu_app/widget/asset_detail_card.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailAssetPage extends StatefulWidget {
  @override
  State<DetailAssetPage> createState() => _DetailAssetPageState();
}

class _DetailAssetPageState extends State<DetailAssetPage> {
  List<Color> gradientColors = [primaryColor, primary200Color];
  double filePercent = 25.0;

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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          )
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '총 수익',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '2024.04.11 기준',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Text(
                      '45,000원',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
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
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('추가하기'),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
