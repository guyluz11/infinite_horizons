import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/tip.dart';

abstract class StudyTypeAbstract {
  StudyTypeAbstract(this.studyType);

  static StudyTypeAbstract? instance;

  TipType studyType;

  EnergyType energy = EnergyType.undefined;

  @protected
  List<Tip> tips = [];

  void setTipValue(int id, bool value) {
    final Tip? tip = tips.firstWhereOrNull((element) => element.id == id);
    if (tip == null) {
      tips.add(
        tipsList.firstWhere((element) => element.id == id)..selected = value,
      );
      return;
    }
    tip.selected = value;
  }

  List<Tip> getTips() =>
      tipsList.where((element) => element.type == TipType.general).toList();

  Tip getTipById(int id) => tips.firstWhere((element) => element.id == id);
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
