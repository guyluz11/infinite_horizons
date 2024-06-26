import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TextAreaOrganism extends StatefulWidget {
  @override
  State<TextAreaOrganism> createState() => _TextAreaOrganismState();
}

class _TextAreaOrganismState extends State<TextAreaOrganism> {
  @override
  void initState() {
    super.initState();
    freeText = PreferencesController.instance
            .getString(PreferenceKeys.freeText.name) ??
        '';
  }

  late String freeText;

  void onChanged(String text) => PreferencesController.instance
      .setString(PreferenceKeys.freeText.name, text);

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'notes',
      scaffold: false,
      expendChild: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardAtom(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextAtom(
                    'What is on your mind',
                    variant: TextVariant.smallTitle,
                  ),
                  const SeparatorAtom(),
                  const SeparatorAtom(),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: freeText,
                    onChanged: onChanged,
                    autofocus: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
