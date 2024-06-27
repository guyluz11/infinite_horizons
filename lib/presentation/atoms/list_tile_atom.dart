import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ListTileAtom extends StatelessWidget {
  const ListTileAtom(
    this.title, {
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

    return ListTile(
      enabled: enable,
      contentPadding: EdgeInsets.zero,
      title: titleWidget,
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
