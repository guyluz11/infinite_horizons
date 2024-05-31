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
    freeText = PreferencesController.instance.getString('freeText') ?? '';
  }

  late String freeText;

  void onChanged(String text) =>
      PreferencesController.instance.setString('freeText', text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBarMolecule(
          title: 'Notes',
          topBarType: TopBarType.none,
          margin: false,
        ),
        const SeparatorAtom(variant: SeparatorVariant.farApart),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardAtom(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextAtom(
                        'Free your mind',
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
        ),
      ],
    );
  }
}
