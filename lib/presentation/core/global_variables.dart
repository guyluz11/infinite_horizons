import 'dart:core';

import 'package:flutter/material.dart';

class GlobalVariables {
  static const int breakTimeRatio = 5;

  static Duration breakTime(Duration studyTime) => Duration(
        milliseconds: studyTime.inMilliseconds ~/ breakTimeRatio,
      );
  static EdgeInsetsGeometry defaultPadding = const EdgeInsets.all(8.0);
}
