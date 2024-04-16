import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class EnergySelectionMolecule extends StatefulWidget {
  const EnergySelectionMolecule(this.callback);

  final VoidCallback callback;

  @override
  State<EnergySelectionMolecule> createState() =>
      _EnergySelectionMoleculeState();
}

class _EnergySelectionMoleculeState extends State<EnergySelectionMolecule> {
  late EnergyType energy;

  @override
  void initState() {
    super.initState();
    energy = StudyTypeAbstract.instance!.energy;
  }

  void onChanged(EnergyType? type) {
    setState(() {
      energy = type ?? EnergyType.undefined;
    });
    StudyTypeAbstract.instance!.energy = energy;
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextAtom('Classic Pomodoro:'),
        const SeparatorAtom(),
        ListTileAtom(
          '${EnergyType.medium.previewName} - ${EnergyType.medium.duration.inMinutes}m',
          Radio<EnergyType>(
            value: EnergyType.medium,
            groupValue: energy,
            onChanged: onChanged,
          ),
        ),
        const SeparatorAtom(variant: SeparatorVariant.farAppart),
        const TextAtom('Custom:'),
        const SeparatorAtom(),
        Column(
          children: [
            ListTileAtom(
              '${EnergyType.max.previewName} - ${EnergyType.max.duration.inMinutes}m',
              Radio<EnergyType>(
                value: EnergyType.max,
                groupValue: energy,
                onChanged: onChanged,
              ),
            ),
            ListTileAtom(
              '${EnergyType.veryHigh.previewName} - ${EnergyType.veryHigh.duration.inMinutes}m',
              Radio<EnergyType>(
                value: EnergyType.veryHigh,
                groupValue: energy,
                onChanged: onChanged,
              ),
            ),
            ListTileAtom(
              '${EnergyType.high.previewName} - ${EnergyType.high.duration.inMinutes}m',
              Radio<EnergyType>(
                value: EnergyType.high,
                groupValue: energy,
                onChanged: onChanged,
              ),
            ),
            ListTileAtom(
              '${EnergyType.low.previewName} - ${EnergyType.low.duration.inMinutes}m',
              Radio<EnergyType>(
                value: EnergyType.low,
                groupValue: energy,
                onChanged: onChanged,
              ),
            ),
            ListTileAtom(
              '${EnergyType.veryLow.previewName} - ${EnergyType.veryLow.duration.inMinutes}m',
              Radio<EnergyType>(
                value: EnergyType.veryLow,
                groupValue: energy,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
