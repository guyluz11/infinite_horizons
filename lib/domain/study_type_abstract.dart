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
      ];

  Tip getTipById(int id) => tips.firstWhere((element) => element.id == id);
}

enum StudyType {
  undefined('Undefined'),
  analytically('Analytically'),
  creatively('Creatively'),
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
  undefined('undefined', 0),
  veryLow('Very Low', 5),
  low('Low', 10),
  medium('Medium', 25),
  high('High', 40),
  veryHigh('Very High', 60),
  max('Max', 90),
  ;

  const EnergyType(this.previewName, this.minutes);
  final int minutes;
  final String previewName;
}
