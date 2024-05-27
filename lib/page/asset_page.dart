import 'package:devu_app/asset_bloc.dart';
import 'package:devu_app/asset_event.dart';
import 'package:devu_app/asset_state.dart';
import 'package:devu_app/data/model/asset.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/page/detail_asset_page.dart';
import 'package:devu_app/page/setup_asset_page.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/widget/asset_card.dart';
import 'package:devu_app/widget/expandable_page_view.dart';
import 'package:devu_app/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetPage extends StatefulWidget {
  final pageName;
  List<Tag> labelList = [
    Tag('예금', Colors.red.value),
    Tag('정기', Colors.blue.value),
    Tag('추가', Colors.green.value)
  ];

  AssetPage(this.pageName);

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AssetBloc>(context).add(LoadAssetEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AssetBloc, AssetState>(builder: (context, state) {
          return Column(
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
                          state is AssetLoadSuccessState
                              ? '${totalIncome(state.assetList).toPriceString()}원'
                              : '0원',
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SetupAssetPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '추가하기',
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
                  child: state is AssetLoadSuccessState
                      ? state.assetList.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ExpandablePageView(
                                  onPageChanged: onPageViewChange,
                                  scrollDirection: Axis.horizontal,
                                  controller: PageController(
                                    viewportFraction: 0.8,
                                  ),
                                  itemCount: state.assetList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailAssetPage(state
                                                        .assetList[index])));
                                      },
                                      child: AssetCard(state.assetList[index]),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: SizedBox(
                                    height: 8,
                                    width: double.infinity,
                                    child: Center(
                                      child: ListView.separated(
                                        itemCount: state.assetList.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                            )
                          : Center(
                              child:
                                  Text('목표자산이 존재하지 않습니다.\n추가하기 버튼을 통해 추가해주세요.'),
                            )
                      : Center(
                          child: Text('데이터를 가져오지 못했습니다.\n다시 시도해주세요.'),
                        ))
            ],
          );
        }),
      ),
    );
  }

  void onPageViewChange(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }

  int totalIncome(List<Asset> assetList) {
    final totalIncome = assetList.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.incomeList.fold(
                0, (previousValue, element) => previousValue + element.value));
    return totalIncome;
  }
}
