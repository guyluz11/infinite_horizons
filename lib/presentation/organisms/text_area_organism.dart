import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TextAreaOrganism extends StatefulWidget {
  @override
  State<TextAreaOrganism> createState() => _TextAreaOrganismState();
}

class _TextAreaOrganismState extends State<TextAreaOrganism>
    with AutomaticKeepAliveClientMixin<TextAreaOrganism> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        const TopBarMolecule(
          title: 'Free Text Area',
          topBarType: TopBarType.none,
          margin: false,
        ),
        const SeparatorAtom(variant: SeparatorVariant.farApart),
        const TextAtom(
          'Whenever unrelated thought pops up during your session just write it down and your brain will be free',
          variant: TextVariant.smallTitle,
        ),
        const SeparatorAtom(),
        Expanded(
          child: TextFormField(
            minLines: 6,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ],
    );
  }
}
