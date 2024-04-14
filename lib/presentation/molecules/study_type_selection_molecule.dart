import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class StudyTypeSelectionMolecule extends StatefulWidget {
  @override
  State<StudyTypeSelectionMolecule> createState() =>
      _StudyTypeSelectionMoleculeState();
}

class _StudyTypeSelectionMoleculeState
    extends State<StudyTypeSelectionMolecule> {
  StudyType selectedType = StudyType.undefined;

  void onChanged(StudyType? type) {
    setState(() {
      selectedType = type ?? StudyType.undefined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListTileAtom(
            StudyType.analytically.name,
            Radio<StudyType>(
              value: StudyType.analytically,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
          ListTileAtom(
            StudyType.creatively.name,
            Radio<StudyType>(
              value: StudyType.creatively,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
