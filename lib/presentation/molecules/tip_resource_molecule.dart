import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/molecules/top_bar_molecule.dart';

class TipResourceMolecule extends StatelessWidget {
  const TipResourceMolecule(
      {required this.innerWidget, required this.title, super.key,
      this.topBarType = TopBarType.back,
      this.separatorVariant = SeparatorVariant.closeWidgets,});
  final Widget innerWidget;
  final TopBarType topBarType;
  final String title;
  final SeparatorVariant separatorVariant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarMolecule(
            topBarType: topBarType,
            title: title,
          ),
          SeparatorAtom(variant: separatorVariant),
          Expanded(child: innerWidget),
        ],
      ),
    );
  }
}
