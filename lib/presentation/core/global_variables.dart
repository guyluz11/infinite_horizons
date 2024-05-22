import 'dart:core';

import 'package:flutter/widgets.dart';

class GlobalVariables {
  static const int breakTimeRatio = 5;
  static const BoxConstraints maxWidth = BoxConstraints(maxWidth: 600);

  static Duration breakTime(Duration studyTime) => Duration(
        milliseconds: studyTime.inMilliseconds ~/ breakTimeRatio,
      );
}
