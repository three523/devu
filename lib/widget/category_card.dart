import 'package:devu_app/data/model/expense_category.dart';
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

  ExpenseCategory? category;
  Function(ExpenseCategory?, int)? updatePrice;

  CategoryCard(this.filePercent,
      {CardType? cardType, this.category, this.updatePrice})
      : cardType = cardType ?? CardType.view;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<Color> gradientColors = [primaryColor, primary200Color];
  late TextEditingController priceController = TextEditingController(
      text: widget.category != null
          ? widget.category!.belowMoeny.toPriceString()
          : '0');

  late int previousPrice = widget.category?.belowMoeny ?? 0;
  late int price = widget.category?.belowMoeny ?? 0;

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
                  Text(widget.category?.title ?? ''),
                  widget.cardType == CardType.view
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.category?.expenseList
                                      .fold(
                                          0,
                                          (value, element) =>
                                              value + -element.value)
                                      .toPriceString() ??
                                  '0',
                              style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '/${formatToKoreanNumber(widget.category?.belowMoeny ?? 0)}',
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
                                    -usedMoneyRate().toDouble() / 100,
                                    -usedMoneyRate().toDouble() / 100,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text("${-usedMoneyRate()}%"),
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
                                  updatePrice(-price);
                                  price = 0;
                                } else {
                                  updatePrice(-10000);
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

                                updatePrice(10000);
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
                    '매일 ${everyDaysAvailableMoney(widget.cardType == CardType.input)}원씩 쓸 수 있어요',
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
      widget.updatePrice!(widget.category, addPrice);
    }
  }

  int everyDaysAvailableMoney(bool isFirstDayOfMonth) {
    final category = widget.category;
    if (category != null) {
      final int compareDay;
      final now = DateTime.now();
      if (isFirstDayOfMonth) {
        compareDay = 1;
      } else {
        compareDay = now.day;
      }
      final currentMonthLastDay = DateTime(now.year, now.month + 1, 0).day;
      final remainigDays = currentMonthLastDay - compareDay;

      int usedMoney = 0;

      if (isFirstDayOfMonth == false) {
        usedMoney = category.expenseList
            .fold(0, (previousValue, element) => previousValue + element.value);
      }
      final leftMoney = category.belowMoeny + usedMoney;
      if (leftMoney <= 0) {
        return 0;
      }
      return (leftMoney / remainigDays).floor();
    }
    return 0;
  }

  int usedMoneyRate() {
    final category = widget.category;
    if (category != null) {
      final usedMoney = category.expenseList
          .fold(0, (previousValue, element) => previousValue + element.value);
      if (usedMoney == 0) {
        return 0;
      }
      final belowMoney = category.belowMoeny;

      if (belowMoney == 0) {
        return -100;
      }
      final usedMoneyRate = (usedMoney / belowMoney) * 100;
      return usedMoneyRate.round();
    }
    return 0;
  }
}
