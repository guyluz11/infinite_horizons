import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/study_type_analytical.dart';
import 'package:infinite_horizons/domain/study_type_creatively.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class StudyTypeSelectionMolecule extends StatefulWidget {
  const StudyTypeSelectionMolecule(this.onSelected);

  final VoidCallback onSelected;

  @override
  State<StudyTypeSelectionMolecule> createState() =>
      _StudyTypeSelectionMoleculeState();
}

class _StudyTypeSelectionMoleculeState
    extends State<StudyTypeSelectionMolecule> {
  late TipType selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = StudyTypeAbstract.instance?.studyType ?? TipType.undefined;
  }

  void onChanged(TipType? type) {
    setState(() {
      selectedType = type ?? TipType.undefined;
    });
    if (selectedType == TipType.analytical) {
      StudyTypeAbstract.instance = StudyTypeAnalytical();
    } else {
      StudyTypeAbstract.instance = StudyTypeCreatively();
    }
    widget.onSelected();
  }

  @override
  Widget build(BuildContext context) {
    return MarginedExpandedAtom(
      child: Column(
        children: [
          const TopBarMolecule(
            title: 'study_type',
            topBarType: TopBarType.none,
            margin: false,
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          CardAtom(
            child: Column(
              children: [
                studyTypeRadioButton(
                    onChanged, selectedType, TipType.analytical),
                studyTypeRadioButton(onChanged, selectedType, TipType.creative),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studyTypeRadioButton(
    void Function(TipType) onChanged,
    TipType selectedType,
    TipType buttonType,
  ) {
    final String subtitle = (buttonType == TipType.analytical
                ? tipsList.firstWhereOrNull(
                    (element) => element.text == 'recommended_morning',
                  )
                : tipsList.firstWhereOrNull(
                    (element) => element.text == 'recommended_evening',
                  ))
            ?.text ??
        '';

    return InkWell(
      onTap: () {
        VibrationController.instance.vibrate(VibrationType.light);
        onChanged(buttonType);
      },
      child: ListTileAtom(
        buttonType.name,
        leading: Radio<TipType>(
          value: buttonType,
          groupValue: selectedType,
          onChanged: (value) => onChanged(value ?? TipType.undefined),
        ),
        subtitle: subtitle,
      ),
    );
  }
}
