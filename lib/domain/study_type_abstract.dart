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
  undefined('undefined', Duration.zero),
  veryLow('Very Low', Duration(minutes: 5)),
  low('Low', Duration(minutes: 10)),
  medium('Medium', Duration(minutes: 25)),
  high('High', Duration(minutes: 40)),
  veryHigh('Very High', Duration(minutes: 60)),
  max('Max', Duration(minutes: 90)),
  ;

  const EnergyType(this.previewName, this.duration);
  final Duration duration;
  final String previewName;
}
