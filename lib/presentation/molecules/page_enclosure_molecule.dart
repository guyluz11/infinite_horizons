import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class PageEnclosureMolecule extends StatelessWidget {
  const PageEnclosureMolecule({
    required this.title,
    required this.child,
    this.margin = true,
    this.topBarTranslate = true,
    this.topBarType = TopBarType.none,
    this.scaffold = true,
    this.topBarRightOnTap,
    this.expendChild = true,
    super.key,
  });

  final Widget child;
  final String title;
  final bool topBarTranslate;
  final bool margin;
  final bool scaffold;
  final TopBarType topBarType;
  final VoidCallback? topBarRightOnTap;
  final bool expendChild;

  Widget topBarHelper() {
    return Column(
      children: [
        TopBarMolecule(
          topBarType: topBarType,
          title: title,
          margin: false,
          translate: topBarTranslate,
          rightOnTap: topBarRightOnTap,
        ),
        const SeparatorAtom(variant: SeparatorVariant.farApart),
        Expanded(
          child: child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget page = topBarHelper();

    if (margin) {
      page = MarginedExpandedAtom(child: page);
    }

    if (scaffold) {
      page = Scaffold(body: page);
    }
    if (expendChild) {
      page = Expanded(child: page);
    }

    return page;
  }
}
