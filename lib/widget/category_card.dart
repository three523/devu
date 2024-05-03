import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CardType { view, input }

class CategoryCard extends StatefulWidget {
  final double filePercent;
  CardType cardType;

  String? categoryName;
  Function(int)? updatePrice;

  CategoryCard(this.filePercent,
      {CardType? cardType, this.categoryName, this.updatePrice})
      : cardType = cardType ?? CardType.view;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<Color> gradientColors = [primaryColor, primary200Color];
  TextEditingController priceController = TextEditingController(text: '0');

  int previousPrice = 0;
  int price = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        constraints: BoxConstraints(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 14, left: 12.0, right: 12.0, bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.categoryName ?? ''),
                  widget.cardType == CardType.view
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '120,500',
                              style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '/24만',
                              style: TextStyle(fontSize: contentTextSize),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${formatToKoreanNumber(price)}원',
                              textAlign: TextAlign.right,
                            )
                          ],
                        ),
                ],
              ),
            ),
            widget.cardType == CardType.view
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 8,
                            width: double.infinity,
                            // color: primaryColor,
                            decoration: BoxDecoration(
                                // color: primary200Color,
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  stops: [
                                    widget.filePercent.round() / 100,
                                    widget.filePercent.round() / 100,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text("${widget.filePercent.round()}%"),
                      ],
                    ),
                  )
                : Expanded(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (price < 10000) {
                                  if (widget.updatePrice != null) {
                                    widget.updatePrice!(-price);
                                  }
                                  price = 0;
                                } else {
                                  if (widget.updatePrice != null) {
                                    widget.updatePrice!(-10000);
                                  }
                                  price -= 10000;
                                }
                                priceController.text = price.toPriceString();
                              });
                            },
                            icon: Icon(Icons.remove)),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.center,
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: priceController,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  previousPrice = price;
                                  price = 0;
                                  updatePrice(0 - price);
                                } else {
                                  int newPrice = value.toPrice() ?? price;
                                  previousPrice = price;
                                  price = newPrice;
                                  updatePrice(newPrice - price);
                                }
                                priceController.text = price.toPriceString();
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              const maxValue = 9223372036854775807;
                              if (price >= maxValue) {
                                return;
                              }
                              setState(() {
                                price += 10000;
                                if (widget.updatePrice != null) {
                                  widget.updatePrice!(10000);
                                }
                                priceController.text = price.toPriceString();
                              });
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                  ),
            Container(
              height: 52.0,
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '매일 4,000원씩 쓸 수 있어요',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updatePrice(int addPrice) {
    if (widget.updatePrice != null) {
      widget.updatePrice!(addPrice);
    }
  }
}
