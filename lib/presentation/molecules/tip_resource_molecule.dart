import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TipResourceMolecule extends StatefulWidget {
  const TipResourceMolecule({
    required this.innerWidget,
    required this.title,
    super.key,
    this.topBarType = TopBarType.back,
    this.separatorVariant = SeparatorVariant.closeWidgets,
  });
  final Widget innerWidget;
  final TopBarType topBarType;
  final String title;
  final SeparatorVariant separatorVariant;

  @override
  State<TipResourceMolecule> createState() => _TipResourceMoleculeState();
}

class _TipResourceMoleculeState extends State<TipResourceMolecule> {
  EdgeInsetsGeometry get padding {
    if (GlobalVariables.isFullScreen.value) {
      return GlobalVariables.zeroPadding;
    }
    return GlobalVariables.defaultPadding;
  }

  void listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GlobalVariables.isFullScreen.addListener(listener);
  }

  @override
  void dispose() {
    GlobalVariables.isFullScreen.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding,
        child: Column(
          children: [
            if (!GlobalVariables.isFullScreen.value)
              TopBarMolecule(
                topBarType: widget.topBarType,
                title: widget.title,
              ),
            SeparatorAtom(variant: widget.separatorVariant),
            Expanded(child: widget.innerWidget),
          ],
        ),
      ),
    );
  }
}
