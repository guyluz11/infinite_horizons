import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/objects/energy_level.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';

abstract class StudyTypeAbstract {
  StudyTypeAbstract(this.tipType);

  static StudyTypeAbstract? instance;

  TipType tipType;

  EnergyLevel? _timerStates;

  void setTimerStates(EnergyType energy) =>
      _timerStates = EnergyLevel.fromEnergyType(energy);

  EnergyLevel getTimerStates() =>
      _timerStates ?? EnergyLevel.fromEnergyType(EnergyType.undefined);

  @protected
  List<Tip> tips = [];

  void setTipValue(int id, bool value) {
    final Tip? tip =
        tips.firstWhereOrNull((element) => element.itemCountNumber == id);
    if (tip == null) {
      tips.add(
        tipsList.firstWhere((element) => element.itemCountNumber == id)
          ..selected = value,
      );
      return;
    }
    tip.selected = value;
  }

  List<Tip> getTips() =>
      tipsList.where((element) => element.type == TipType.general).toList();

  Tip getTipById(int id) =>
      tips.firstWhere((element) => element.itemCountNumber == id);
}
