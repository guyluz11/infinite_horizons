import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/timer_states.dart';
import 'package:infinite_horizons/domain/tip.dart';

abstract class StudyTypeAbstract {
  StudyTypeAbstract(this.studyType);

  static StudyTypeAbstract? instance;

  TipType studyType;

  TimerStates? _timerStates;

  void setTimerStates(EnergyType energy) =>
      _timerStates = TimerStates.fromEnergyType(energy);

  TimerStates getTimerStates() =>
      _timerStates ?? TimerStates.fromEnergyType(EnergyType.undefined);

  @protected
  List<Tip> tips = [];

  void setTipValue(int id, bool value) {
    final Tip? tip = tips.firstWhereOrNull((element) => element.number == id);
    if (tip == null) {
      tips.add(
        tipsList.firstWhere((element) => element.number == id)
          ..selected = value,
      );
      return;
    }
    tip.selected = value;
  }

  List<Tip> getTips() =>
      tipsList.where((element) => element.type == TipType.general).toList();

  Tip getTipById(int id) => tips.firstWhere((element) => element.number == id);
}
