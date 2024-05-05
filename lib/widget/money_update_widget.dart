import 'dart:ffi';

import 'package:devu_app/utils/extenstion.dart';
import 'package:flutter/material.dart';

enum ValueType { integer, decimal }

// extension ValueTypeExtension on ValueType {
//   String valueToString(double value) {
//     switch (this) {
//       case ValueType.decimal:
//       return value.toString();
//       case ValueType.integer:
//       return value.round().toPriceString();
//     }
//   }
// }

// class MoneyUpdateWidget extends StatefulWidget {
//   Function resultHandler;
//   double updateValue;
//   double initValue;
//   ValueType valueType;
//   Function(double) updatePrice;
//   late double result = initValue;

//   MoneyUpdateWidget(this.resultHandler, this.updateValue, this.updatePrice,
//       {double? initValue, ValueType? valueType})
//       : initValue = initValue ?? 0,
//         valueType = valueType ?? ValueType.integer;

//   @override
//   State<MoneyUpdateWidget> createState() => _MoneyUpdateWidgetState();
// }

// class _MoneyUpdateWidgetState extends State<MoneyUpdateWidget> {
//   late final _updateValue = widget.updateValue;
//   late final _resultHandler = widget.resultHandler;
//   late final _valueType = widget.valueType;
//   late final updatePrice = widget.updatePrice;
//   late double value = widget.initValue;

//   late double previousPrice = widget.initValue;
//   TextEditingController priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (value < 10000) {
//                                   if (widget.updatePrice != null) {
//                                     widget.updatePrice!(-value);
//                                   }
//                                   value = 0;
//                                 } else {
//                                   if (widget.updatePrice != null) {
//                                     widget.updatePrice!(-10000);
//                                   }
//                                   value -= 10000;
//                                 }
//                                 priceController.text = _valueType.valueToString(value);
//                               });
//                             },
//                             icon: Icon(Icons.remove)),
//                         Expanded(
//                           child: TextField(
//                             textAlign: TextAlign.center,
//                             maxLines: null,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                             ),
//                             controller: priceController,
//                             onChanged: (value) {
//                               setState(() {
//                                 if (value.isEmpty) {
//                                   previousPrice = value;
//                                   value = 0;
//                                   updatePrice(0 - value);
//                                 } else {
//                                   double newPrice = value.toPrice() ?? value;
//                                   previousPrice = value;
//                                   value = newPrice;
//                                   updatePrice(newPrice - value);
//                                 }
//                                 priceController.text = _valueType == ValueType.
//                               });
//                             },
//                             keyboardType: TextInputType.number,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               const maxValue = 9223372036854775807;
//                               if (value >= maxValue) {
//                                 return;
//                               }
//                               setState(() {
//                                 value += 10000;
//                                 if (widget.updatePrice != null) {
//                                   widget.updatePrice!(10000);
//                                 }
//                                 priceController.text = value.toPriceString();
//                               });
//                             },
//                             icon: Icon(Icons.add))
//                       ],
//                     ),;
//   }
// }
