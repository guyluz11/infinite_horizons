import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/tip.dart';

abstract class StudyTypeAbstract {
  StudyTypeAbstract(this.studyType);

  static StudyTypeAbstract? instance;

  StudyType studyType;

  EnergyType energy = EnergyType.undefined;

  @protected
  List<Tip> tips = [];

  void setTipValue(int id, bool value) {
    tips.firstWhere((element) => element.id == id).selected = value;
  }

  List<Tip> getTips() => [
        tipsList[0],
        tipsList[1],
        tipsList[2],
      ];

  Tip getTipById(int id) => tips.firstWhere((element) => element.id == id);
}

enum StudyType {
  undefined('undefined'),
  analytically('analytically'),
  creatively('creatively'),
  ;

  const StudyType(this.previewName);

  final String previewName;
}

extension StudyTypeExtension on StudyType {
  static StudyType fromString(String typeAsString) {
    return StudyType.values.firstWhere(
      (element) => element.toString().split('.').last == typeAsString,
      orElse: () => StudyType.undefined,
    );
  }
}

enum EnergyType {
  undefined('undefined', Duration.zero),
  veryLow('very_low', Duration(minutes: 5)),
  low('low', Duration(minutes: 10)),
  medium('medium', Duration(minutes: 25)),
  high('high', Duration(minutes: 40)),
  veryHigh('very_high', Duration(minutes: 60)),
  max('max', Duration(minutes: 90)),
  ;

  const EnergyType(
    this.previewName,
    this.duration,
  );

  final Duration duration;
  final String previewName;
}
