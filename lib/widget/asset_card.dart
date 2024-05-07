import 'package:devu_app/data/resource.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssetCard extends StatefulWidget {
  @override
  State<AssetCard> createState() => _AssetCardState();
}

class _AssetCardState extends State<AssetCard> {
  final GlobalKey _globalKey = GlobalKey();

  List<String> labelList = ['저축', '배당금', '예금'];

  List<Color> gradientColors = [secondaryColor, primary200Color];

  final double filePercent = 25;

  final int dDay = 255;

  final double todayIncomPersent = 8.8;

  Size size = const Size(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        size = getCardSize(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: _globalKey,
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '신혼 여행비',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '목표',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '500만원',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LabelWidget(
                          '7%',
                          Colors.green,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 22, vertical: 2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      height: 1.0,
                      width: size.width * 0.7,
                      color: Colors.grey,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        for (int i = 0; i < labelList.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: LabelWidget(labelList[i], Colors.redAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2)),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
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
                            filePercent.round() / 100,
                            filePercent.round() / 100,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text("${filePercent.round()}%"),
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
                    'D - $dDay',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      '이 속도면 250일 안에 달성하겠어요\n매일 13,000원이 필요해요',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: LabelWidget(
                          todayIncomPersent.toString(),
                          Colors.green,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          icon: Icons.trending_up,
                        ),
                      ),
                      Text(
                        '현재 수익은 54만원 입니다.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Size getCardSize(BuildContext context) {
    if (_globalKey.currentContext != null) {
      final RenderBox renderBox =
          _globalKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return Size(0.0, 0.0);
  }
}
