import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ListTileAtom extends StatelessWidget {
  const ListTileAtom(
    this.title, {
    this.titleIcon,
    this.trailing,
    this.leading,
    this.subtitle,
    this.translateTitle = true,
    this.translateSubtitle = true,
    this.onTap,
    this.enable = true,
    this.variant = ListTileSubtitleVariant.text,
    this.isCrossed = false,
  });

  final String title;
  final IconData? titleIcon;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool translateTitle;
  final bool translateSubtitle;
  final VoidCallback? onTap;
  final bool enable;
  final ListTileSubtitleVariant variant;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;
    switch (variant) {
      case ListTileSubtitleVariant.text:
        titleWidget = TextAtom(title, translate: translateTitle);
      case ListTileSubtitleVariant.strikethrough:
        titleWidget = AnimatedLineThroughAtom(
          isCrossed: isCrossed,
          isSound: false,
          child: TextAtom(title, translate: translateTitle),
        );
    }

    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      enabled: enable,
      contentPadding: EdgeInsets.zero,
      title: titleIcon == null
          ? titleWidget
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child:
                      FaIcon(titleIcon, size: textTheme.bodyMedium!.fontSize),
                ),
                const SeparatorAtom(variant: SeparatorVariant.relatedElements),
                Flexible(child: titleWidget),
              ],
            ),
      subtitle: subtitle == null
          ? null
          : TextAtom(subtitle!, translate: translateSubtitle),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

enum ListTileSubtitleVariant {
  text,
  strikethrough,
}
