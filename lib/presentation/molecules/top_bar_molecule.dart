import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class TopBarMolecule extends StatelessWidget {
  const TopBarMolecule({
    required this.topBarType,
    this.title,
    this.leftOnTap,
    this.rightOnTap,
    this.rightPopupMenu,
    this.translate = true,
    this.margin = true,
    this.rightIcon,
  });

  final TopBarType topBarType;
  final String? title;
  final VoidCallback? leftOnTap;
  final VoidCallback? rightOnTap;

  final List<PopupMenuEntryAtom>? rightPopupMenu;
  final IconData? rightIcon;
  final bool translate;
  final bool margin;

  @override
  Widget build(BuildContext context) {
    final Widget widget = topBarWidget(context);
    return SafeArea(
      bottom: false,
      child: margin
          ? MarginedExpandedAtom(
              child: widget,
            )
          : widget,
    );
  }

  Widget topBarWidget(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    switch (topBarType) {
      case TopBarType.none:
        return Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                TextAtom(
                  title ?? '',
                  variant: TextVariant.title,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (rightPopupMenu != null)
                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) =>
                              rightPopupMenu!,
                        ),
                      if (rightOnTap != null)
                        ButtonAtom(
                          variant: ButtonVariant.lowEmphasisIcon,
                          onPressed: rightOnTap!,
                          translate: translate,
                          icon: Icons.more_vert,
                        ),
                      if (rightPopupMenu == null && rightOnTap == null)
                        TextAtom(
                          '',
                          style: textTheme.headlineSmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );

      case TopBarType.back:
      case TopBarType.close:
        return Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                ButtonAtom(
                  onPressed: () {
                    if (leftOnTap != null) {
                      return leftOnTap!();
                    }
                    Navigator.of(context).pop();
                  },
                  icon: topBarType == TopBarType.close
                      ? Icons.close_rounded
                      : Icons.arrow_back_ios_rounded,
                  variant: ButtonVariant.lowEmphasisIcon,
                ),
                const SeparatorAtom(
                  variant: SeparatorVariant.relatedElements,
                ),
                Expanded(
                  child: TextAtom(
                    title ?? '',
                    variant: TextVariant.title,
                  ),
                ),
                Row(
                  children: [
                    if (rightOnTap != null)
                      ButtonAtom(
                        variant: ButtonVariant.lowEmphasisIcon,
                        onPressed: rightOnTap!,
                        translate: translate,
                        icon: rightIcon ?? Icons.more_vert,
                      )
                    else
                      TextAtom(
                        '',
                        style: textTheme.headlineSmall,
                      ),
                  ],
                ),
              ],
            ),
          ],
        );
    }
  }
}

enum TopBarType { none, back, close }

enum SampleItem { first, second }
