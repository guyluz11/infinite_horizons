import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/study_type_abstract.dart';
import 'package:infinite_horizons/domain/objects/study_type_analytical.dart';
import 'package:infinite_horizons/domain/objects/study_type_creatively.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
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
    selectedType = StudyTypeAbstract.instance?.tipType ?? TipType.undefined;
    if (PreferencesController.instance
            .getInt(PreferenceKeys.loginCounter.name)! <=
        1) {
      requestNotificationPermissions();
    }
  }

  Future requestNotificationPermissions() async {
    await NotificationsController.instance.generalPermission();
    await NotificationsController.instance.preciseAlarmPermission();
  }

  void onChanged(TipType? type) {
    setState(() {
      selectedType = type ?? TipType.undefined;
    });
    StudyTypeAbstract.instance = selectedType == TipType.analytical
        ? StudyTypeAnalytical()
        : StudyTypeCreatively();

    PreferencesController.instance
        .setString(PreferenceKeys.tipType.name, selectedType.name);

    widget.onSelected();
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      scaffold: false,
      title: 'study_type',
      child: Column(
        children: [
          CardAtom(
            child: Column(
              children: [
                studyTypeRadioButton(
                  onChanged,
                  selectedType,
                  TipType.analytical,
                ),
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
                    (element) => element.id == 'recommended in the morning',
                  )
                : tipsList.firstWhereOrNull(
                    (element) => element.id == 'recommended in the evening',
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
