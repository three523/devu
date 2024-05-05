import 'package:devu_app/data/resource.dart';
import 'package:devu_app/widget/asset_card.dart';
import 'package:devu_app/widget/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssetPage extends StatefulWidget {
  final pageName;

  AssetPage(this.pageName);

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          '총 자산',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        '420,000원',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 91, 148, 168),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      Navigator.pushNamed(context, widget.pageName);
                    },
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
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExpandablePageView(
                    onPageChanged: onPageViewChange,
                    scrollDirection: Axis.horizontal,
                    controller: PageController(
                      viewportFraction: 0.8,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return AssetCard();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
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
                  ),
                ],
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
