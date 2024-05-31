import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TipResourceMolecule extends StatefulWidget {
  const TipResourceMolecule({
    required this.title,
    this.innerWidget,
    super.key,
    this.topBarType = TopBarType.back,
    this.separatorVariant = SeparatorVariant.closeWidgets,
    this.url,
  });
  final Widget? innerWidget;
  final TopBarType topBarType;
  final String title;
  final SeparatorVariant separatorVariant;
  final String? url;
  @override
  State<TipResourceMolecule> createState() => _TipResourceMoleculeState();
}

class _TipResourceMoleculeState extends State<TipResourceMolecule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: GlobalVariables.defaultPadding,
        child: Column(
          children: [
            TopBarMolecule(
              topBarType: widget.topBarType,
              title: widget.title,
            ),
            SeparatorAtom(variant: widget.separatorVariant),
            Expanded(
              child: widget.innerWidget!,
            ),
          ],
        ),
      ),
    );
  }
}
