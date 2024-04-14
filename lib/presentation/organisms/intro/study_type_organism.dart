import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class StudyTypeOrganism extends StatefulWidget {
  @override
  State<StudyTypeOrganism> createState() => _StudyTypeOrganismState();
}

class _StudyTypeOrganismState extends State<StudyTypeOrganism> {
  @override
  Widget build(BuildContext context) {
    return StudyTypeSelectionMolecule();
  }
}
