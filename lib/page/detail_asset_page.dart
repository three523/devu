import 'package:devu_app/widget/asset_detail_card.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:flutter/material.dart';

class DetailAssetPage extends StatefulWidget {
  @override
  State<DetailAssetPage> createState() => _DetailAssetPageState();
}

class _DetailAssetPageState extends State<DetailAssetPage> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 24),
            child: AssetDetailCard(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
