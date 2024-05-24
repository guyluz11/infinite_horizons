import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class TopBarMolecule extends StatelessWidget {
  const TopBarMolecule({
    required this.topBarType,
    this.title,
    this.iconColor,
    this.onTap,
    this.secondaryButtonOnTap,
    this.translate = true,
    this.margin = true,
  });

  final TopBarType topBarType;
  final String? title;
  final Color? iconColor;
  final VoidCallback? onTap;
  final VoidCallback? secondaryButtonOnTap;
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
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            if (topBarType != TopBarType.none)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onTap != null) {
                        return onTap!();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      topBarType == TopBarType.close
                          ? Icons.close_rounded
                          : Icons.arrow_back_ios_rounded,
                      color: iconColor,
                      size: textTheme.titleMedium!.fontSize,
                    ),
                  ),
                  const SeparatorAtom(
                    variant: SeparatorVariant.relatedElements,
                  ),
                ],
              ),
            Expanded(
              child: TextAtom(
                title ?? '',
                variant: TextVariant.smallTitle,
              ),
            ),
            Row(
              children: [
                if (secondaryButtonOnTap != null)
                  ButtonAtom(
                    variant: ButtonVariant.iconButton,
                    onPressed: secondaryButtonOnTap!,
                    translate: translate,
                    icon: FontAwesomeIcons.gear,
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

enum TopBarType { none, back, close }
