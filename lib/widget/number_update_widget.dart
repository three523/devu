import 'dart:ffi';

import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:flutter/material.dart';

enum ValueType { money, number }

extension ValueTypeExtension on ValueType {
  String valueToString(num value) {
    switch (this) {
      case ValueType.number:
        return value.toString();
      case ValueType.money:
        return value.round().toPriceString();
    }
  }
}

class NumberUpdateWidget extends StatefulWidget {
  num updateValue;
  num initValue;
  final ValueType valueType;
  Function(num) updatePrice;
  late num result = initValue;

  NumberUpdateWidget(this.updateValue, this.updatePrice,
      {num? initValue, ValueType? valueType})
      : valueType = valueType ?? ValueType.number,
        initValue = initValue ?? 0;

  @override
  _NumberUpdateWidgetState createState() => _NumberUpdateWidgetState();
}

class _NumberUpdateWidgetState extends State<NumberUpdateWidget> {
  late final _updateValue = widget.updateValue;
  late final _valueType = widget.valueType;
  late final updatePrice = widget.updatePrice;
  late num totalNum = widget.initValue;

  late num previousPrice = widget.initValue;
  late TextEditingController priceController =
      TextEditingController(text: _valueType.valueToString(totalNum));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      final num newValue;
                      if (totalNum < _updateValue) {
                        newValue = 0;
                      } else {
                        newValue = totalNum - _updateValue;
                      }
                      totalNum = double.parse(newValue.toStringAsFixed(1));
                      updatePrice(totalNum);
                      priceController.text = _valueType.valueToString(totalNum);
                    });
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
            ),
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
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                controller: priceController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      previousPrice = totalNum;
                      totalNum = 0;
                    } else {
                      num newPrice = value.toDouble() ?? totalNum;
                      previousPrice = totalNum;
                      totalNum = newPrice;
                    }
                    updatePrice(totalNum);
                    priceController.text = _valueType.valueToString(totalNum);
                  });
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  color: primaryColor,
                  onPressed: () {
                    const maxValue = 9223372036854775807;
                    if (totalNum >= maxValue) {
                      return;
                    }
                    setState(() {
                      final newValue = totalNum + _updateValue;
                      totalNum = double.parse(newValue.toStringAsFixed(1));
                      widget.updatePrice(totalNum);
                      priceController.text = _valueType.valueToString(totalNum);
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
