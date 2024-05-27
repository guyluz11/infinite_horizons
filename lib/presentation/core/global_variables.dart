import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class GlobalVariables {
  static const int breakTimeRatio = 5;
  static const BoxConstraints maxWidth = BoxConstraints(maxWidth: 600);

  static Duration breakTime(Duration studyTime) => Duration(
        milliseconds: studyTime.inMilliseconds ~/ breakTimeRatio,
      );
  static EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(8.0);
  static EdgeInsetsGeometry zeroPadding = EdgeInsets.zero;
  static double defaultRadius = 10.0;
  static double defaultBorderWidth = 2.0;
}
