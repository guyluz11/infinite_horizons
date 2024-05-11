import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/study_type_analytical.dart';
import 'package:infinite_horizons/domain/study_type_creatively.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class StudyTypeSelectionMolecule extends StatefulWidget {
  const StudyTypeSelectionMolecule(this.onSelected);

  final VoidCallback onSelected;

  @override
  State<StudyTypeSelectionMolecule> createState() =>
      _StudyTypeSelectionMoleculeState();
}

class _StudyTypeSelectionMoleculeState
    extends State<StudyTypeSelectionMolecule> {
  late StudyType selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = StudyTypeAbstract.instance?.studyType ?? StudyType.undefined;
  }

  void onChanged(StudyType? type) {
    setState(() {
      selectedType = type ?? StudyType.undefined;
    });
    if (selectedType == StudyType.analytically) {
      StudyTypeAbstract.instance = StudyTypeAnalytical();
    } else {
      StudyTypeAbstract.instance = StudyTypeCreatively();
    }
    widget.onSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        studyTypeRadioButton(onChanged, selectedType, StudyType.analytically),
        studyTypeRadioButton(onChanged, selectedType, StudyType.creatively),
      ],
    );
  }

  Widget studyTypeRadioButton(void Function(StudyType?)? onChanged,
      StudyType selectedType, StudyType buttonType) {
    return InkWell(
      onTap: () => onChanged!(buttonType),
      child: ListTileAtom(
        buttonType.previewName,
        Radio<StudyType>(
          value: buttonType,
          groupValue: selectedType,
          onChanged: onChanged,
        ),
        subtitle: buttonType == StudyType.analytically
            ? 'recommended_morning'
            : 'recommended_evening',
      ),
    );
  }
}
