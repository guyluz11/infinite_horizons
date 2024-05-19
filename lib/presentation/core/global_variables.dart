import 'dart:core';

class GlobalVariables {
  static const int breakTimeRatio = 5;

  static Duration breakTime(Duration studyTime) => Duration(
        milliseconds: studyTime.inMilliseconds ~/ breakTimeRatio,
      );
}
