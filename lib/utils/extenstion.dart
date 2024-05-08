// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:math';

import 'package:devu_app/data/repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Compares only [day], [month] and [year] of [DateTime].
  bool compareWithoutTime(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  /// Gets difference of months between [date] and calling object.
  int getMonthDifference(DateTime date) {
    if (year == date.year) return ((date.month - month).abs() + 1);

    var months = ((date.year - year).abs() - 1) * 12;

    if (date.year >= year) {
      months += date.month + (13 - month);
    } else {
      months += month + (13 - date.month);
    }

    return months;
  }

  /// Gets difference of days between [date] and calling object.
  int getDayDifference(DateTime date) => DateTime.utc(year, month, day)
      .difference(DateTime.utc(date.year, date.month, date.day))
      .inDays
      .abs();

  /// Returns The List of date of Current Week, all of the dates will be without
  /// time.

  /// Returns the first date of week containing the current date

  /// Gives formatted date in form of 'month - year'.
  String get formatted => "$month-$year";
  String get formattedDay => "$year/$month/$day";

  /// Returns total minutes this date is pointing at.
  /// if [DateTime] object is, DateTime(2021, 5, 13, 12, 4, 5)
  /// Then this getter will return 12*60 + 4 which evaluates to 724.
  int get getTotalMinutes => hour * 60 + minute;

  /// Returns a new [DateTime] object with hour and minutes calculated from
  /// [totalMinutes].
  DateTime copyFromMinutes([int totalMinutes = 0]) => DateTime(
        year,
        month,
        day,
        totalMinutes ~/ 60,
        totalMinutes % 60,
      );

  /// Returns [DateTime] without timestamp.
  DateTime get withoutTime => DateTime(year, month, day);

  /// Compares time of two [DateTime] objects.
  bool hasSameTimeAs(DateTime other) {
    return other.hour == hour &&
        other.minute == minute &&
        other.second == second &&
        other.millisecond == millisecond &&
        other.microsecond == microsecond;
  }

  bool get isDayStart => hour % 24 == 0 && minute % 60 == 0;

  @Deprecated(
      "This extension is not being used in this package and will be removed "
      "in next major release. Please use withoutTime instead.")
  DateTime get dateYMD => DateTime(year, month, day);
}

extension TimerOfDayExtension on TimeOfDay {
  int get getTotalMinutes => hour * 60 + minute;
}

extension IntExtension on int {
  String appendLeadingZero() {
    return toString().padLeft(2, '0');
  }
}

// 9,000 같이 숫자 구분을 위해 쉼표가 되어있는 경우 사용
extension StringExtension on String {
  int? toPrice() {
    const maxValue = "9,223,372,036,854,775,807";
    if (length > maxValue.length) {
      return null;
    }
    final str = removeFrontZero(this);
    return int.parse(str.replaceAll(",", ""));
  }

  double? toDouble() {
    const maxLength = 20;
    if (length > maxLength) {
      return null;
    }
    return double.tryParse(replaceAll(",", "")) ?? 0;
  }

  String removeFrontZero(String string) {
    if (string.length == 1) {
      return string;
    }
    int startIndex = 0;
    for (int i = 0; i < string.length; i++) {
      if (string[i] == "0") {
        startIndex += 1;
        continue;
      }
      break;
    }
    if (startIndex == string.length) {
      return "0";
    }
    return string.substring(startIndex);
  }

  String toPriceString() {
    var num = int.parse(this);
    var format = NumberFormat('#,###');
    return format.format(num);
  }
}

// 9000 => '9,000' 형식으로 숫자를 쉼표를 추가하여 문자로 변환
extension PriceExtensionInt on int {
  String toPriceString() {
    var format = NumberFormat('#,###');
    return format.format(this);
  }
}

extension PriceExtensionDouble on double {
  String toPriceString() {
    var format = NumberFormat('#,###');
    return format.format(this);
  }
}

extension PriceExtensionNum on num {
  String toPriceString() {
    var format = NumberFormat('#,###');
    return format.format(this);
  }

  num customRound(int place) {
    var valueForPlace = pow(10, place);
    return (this * valueForPlace).round();
  }
}
