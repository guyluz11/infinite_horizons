import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/timer_states.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class EnergySelectionMolecule extends StatefulWidget {
  const EnergySelectionMolecule(this.callback);

  final VoidCallback callback;

  @override
  State<EnergySelectionMolecule> createState() =>
      _EnergySelectionMoleculeState();
}

class _EnergySelectionMoleculeState extends State<EnergySelectionMolecule> {
  late TimerStates timerStates;

  @override
  void initState() {
    super.initState();
    timerStates = StudyTypeAbstract.instance!.getTimerStates();
  }

  void onChanged(EnergyType? type) {
    StudyTypeAbstract.instance!.setTimerStates(type ?? EnergyType.undefined);
    setState(() {
      timerStates = StudyTypeAbstract.instance!.getTimerStates();
    });
    widget.callback();
  }

  Widget energyWidget(EnergyType type) {
    final TimerStates timerStatesTemp = TimerStates.fromEnergyType(type);
    String subtitle = '';

    final TimerSession firstTimerState = timerStatesTemp.sessions.first;

    for (final TimerSession timerState in timerStatesTemp.sessions) {
      if (timerState != firstTimerState) {
        subtitle += ' -> ';
      }
      subtitle =
          '$subtitle${timerState.study.inMinutes}m study -> ${timerState.breakDuration.inMinutes}m break';
    }

    return InkWell(
      onTap: () {
        VibrationController.instance.vibrate(VibrationType.light);
        onChanged(type);
      },
      child: ListTileAtom(
        '${type.previewName.tr()} - ${type.duration.inMinutes}${'minutes_single'.tr()}',
        subtitle: subtitle,
        leading: Radio<EnergyType>(
          value: type,
          groupValue: timerStates.type,
          onChanged: onChanged,
        ),
        translateTitle: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'energy',
      scaffold: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardAtom(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextAtom(
                      'recommended',
                      variant: TextVariant.smallTitle,
                    ),
                    const SeparatorAtom(),
                    // TODO: add trailing icon to see all tips
                    energyWidget(EnergyType.efficient),
                  ],
                ),
              ),
              const SeparatorAtom(variant: SeparatorVariant.farApart),
              CardAtom(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextAtom(
                      'famous_methods',
                      variant: TextVariant.smallTitle,
                    ),
                    const SeparatorAtom(),
                    energyWidget(EnergyType.pomodoro),
                  ],
                ),
              ),
              const SeparatorAtom(variant: SeparatorVariant.farApart),
              CardAtom(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextAtom(
                      'custom',
                      variant: TextVariant.smallTitle,
                    ),
                    const SeparatorAtom(),
                    energyWidget(EnergyType.veryHigh),
                    energyWidget(EnergyType.high),
                    energyWidget(EnergyType.low),
                    energyWidget(EnergyType.veryLow),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
