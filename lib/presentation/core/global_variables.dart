import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalVariables {
  static String appName = 'Infinite Horizons';
  static const BoxConstraints maxWidth = BoxConstraints(maxWidth: 600);

  static EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(8.0);
  static double defaultRadius = 10.0;
  static double defaultBorderWidth = 2.0;
  static DateTime dateTimeToday = DateTime.now();

  static DateTime datTimeTodayOnlyHour(int hour) => dateTimeToday
      .copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      )
      .add(Duration(hours: hour));
}
