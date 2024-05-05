import 'package:devu_app/data/resource.dart';
import 'package:devu_app/page/add_category_page.dart';
import 'package:devu_app/page/add_expenses_page.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:devu_app/widget/home_appbar.dart';
import 'package:devu_app/widget/income_card.dart';
import 'package:devu_app/widget/date_swipe_widget.dart';
import 'package:devu_app/widget/year_month_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  final double defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddExpenses()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: HomeAppBar('/addCategory'),
            ),
            SizedBox(
              width: double.infinity,
              height: 175,
              child: PageView.builder(
                  onPageChanged: onPageViewChange,
                  scrollDirection: Axis.horizontal,
                  controller: PageController(
                    viewportFraction: 0.8,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detailCategory');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryCard(
                          25.0,
                          categoryName: '식비',
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 8,
              width: double.infinity,
              child: Center(
                child: ListView.separated(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: currentPageIndex == index
                            ? null
                            : Border.all(
                                width: 0.5,
                                color: Colors.black,
                              ),
                        borderRadius: BorderRadius.circular(8),
                        color: currentPageIndex == index
                            ? primaryColor
                            : Colors.white,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 4,
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "최근 내역",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('모두보기'),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('2024.04.08 기준'),
                ),
              ],
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
      ),
    );
  }

  void onPageViewChange(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }
}
