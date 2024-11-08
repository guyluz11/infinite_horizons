import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class PageEnclosureMolecule extends StatelessWidget {
  const PageEnclosureMolecule({
    required this.title,
    required this.child,
    this.subTitle,
    this.margin = true,
    this.topMargin = true,
    this.topBarTranslate = true,
    this.topBarType = TopBarType.none,
    this.scaffold = true,
    this.topBarRightOnTap,
    this.rightPopupMenu,
    this.expendChild = true,
    this.topBarRightIcon,
    super.key,
  });

  final Widget child;
  final String title;
  final String? subTitle;
  final bool topBarTranslate;
  final bool margin;
  final bool topMargin;
  final bool scaffold;
  final TopBarType topBarType;
  final VoidCallback? topBarRightOnTap;
  final List<PopupMenuEntry<SampleItem>>? rightPopupMenu;
  final bool expendChild;
  final IconData? topBarRightIcon;

  Widget topBarHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBarMolecule(
          topBarType: topBarType,
          title: title,
          margin: false,
          translate: topBarTranslate,
          rightOnTap: topBarRightOnTap,
          rightPopupMenu: rightPopupMenu,
          rightIcon: topBarRightIcon,
        ),
        if (subTitle != null)
          TextAtom(
            subTitle!,
            variant: TextVariant.smallTitle,
          ),
        if (topMargin) const SeparatorAtom(),
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
