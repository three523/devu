import 'dart:math';

import 'package:devu_app/utils/extenstion.dart';
import 'package:flutter/material.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

Function createNumberFormatterBy(double Function(double num) formatter) {
  double formatNumber(int value, int unit) {
    if (unit < 1) {
      // 부동소수점 오류 때문에 unit < 1인 경우 특별 처리
      final reciprocal = 1 / unit;

      return formatter(value * reciprocal) / reciprocal;
    }

    return formatter(value / unit) * unit;
  }

  ;
  return formatNumber;
}

const units = [
  '',
  '십',
  '백',
  '천',
  '만',
  '십',
  '백',
  '천',
  '억',
  '십',
  '백',
  '천',
  '조',
  '십',
  '백',
  '천',
  '경'
];

List<int> chunk(int value, int byDigits) {
  List<int> result = [];
  String source = value.toString();

  for (int end = source.length; end >= 1; end = end - byDigits) {
    final start = max(end - byDigits, 0);
    final slice = source.substring(start, end);

    result.add(slice.toPrice() ?? 0);
  }

  return result;
}

String formatToKoreanNumber(int value) {
  if (value == 0) {
    return '0';
  }

  int index = 0;
  return chunk(value, 4).fold("", (value, element) {
    if (element == 0) {
      index += 1;
      return value.toString();
    }

    // final val = formatThousands(element);
    final val = commaizeNumber(element);
    final unit = units[index * 4];
    index += 1;

    return "${val}${unit} ${value}";
  });
}

String commaizeNumber(dynamic value) {
  String numStr = value.toString();
  int decimalPointIndex = numStr.indexOf('.');
  RegExp commaizeRegExp = RegExp(r'(\d)(?=(\d\d\d)+(?!\d))');

  return decimalPointIndex > -1
      ? numStr.substring(0, decimalPointIndex).replaceAllMapped(
              commaizeRegExp, (match) => '${match.group(1)},') +
          numStr.substring(decimalPointIndex)
      : numStr.replaceAllMapped(
          commaizeRegExp, (match) => '${match.group(1)},');
}

String formatThousands(int num) {
  String numString = num.toString()
      .split('')
      .reversed
      .toList()
      .mapWithIndex((digit, index) {
        return digit != '0'
            ? '${digit != '0' ? digit : ''}${units[index]}'
            : '';
      })
      .reversed
      .join('');
  return numString;
}

extension MapWithIndex<T> on List<T> {
  List<R> mapWithIndex<R>(R Function(T, int i) callback) {
    List<R> result = [];
    for (int i = 0; i < this.length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}

extension StringMapWithIndex on String {
  List<String> mapWithIndex(String Function(String, int i) callback) {
    List<String> result = [];
    for (int i = 0; i < this.length; i++) {
      String item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}

Color getTextColorForBackground(Color backgroundColor) {
  // 배경색의 밝기 계산
  double brightness = backgroundColor.computeLuminance();

  // 밝기에 따라 텍스트 색상 결정
  return brightness < 0.5 ? Colors.white : Colors.black;
}

int dateTimeToUnixTimestamp(DateTime dateTime) {
  return dateTime.withoutTime.millisecondsSinceEpoch ~/ 1000;
}

DateTime unixTimestampToDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}
