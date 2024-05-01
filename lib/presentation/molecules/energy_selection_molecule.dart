import 'package:easy_localization/easy_localization.dart';
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

  Widget energyWidget(EnergyType type) {
    return InkWell(
      onTap: () => onChanged(type),
      child: ListTileAtom(
        '${type.previewName.tr()} - ${type.duration.inMinutes}${'minutes_single'.tr()}',
        Radio<EnergyType>(
          value: type,
          groupValue: energy,
          onChanged: onChanged,
        ),
        translateTitle: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextAtom('classic_pomodoro'),
        const SeparatorAtom(),
        energyWidget(EnergyType.medium),
        const SeparatorAtom(variant: SeparatorVariant.farApart),
        const TextAtom('custom'),
        const SeparatorAtom(),
        Column(
          children: [
            energyWidget(EnergyType.max),
            energyWidget(EnergyType.veryHigh),
            energyWidget(EnergyType.high),
            energyWidget(EnergyType.low),
            energyWidget(EnergyType.veryLow),
          ],
        ),
      ],
    );
  }
}
