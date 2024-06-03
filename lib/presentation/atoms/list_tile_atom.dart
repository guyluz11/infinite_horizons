import 'package:animated_line_through/animated_line_through.dart';
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
    this.variant = ListTileVariant.regular,
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
  final ListTileVariant variant;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ListTileVariant.regular:
        return ListTile(
          enabled: enable,
          contentPadding: EdgeInsets.zero,
          title: TextAtom(title, translate: translateTitle),
          subtitle: subtitle == null
              ? null
              : TextAtom(subtitle!, translate: translateSubtitle),
          leading: leading,
          trailing: trailing,
          onTap: onTap,
        );
      case ListTileVariant.strikethrough:
        return ListTile(
          enabled: enable,
          contentPadding: EdgeInsets.zero,
          title: AnimatedLineThrough(
            duration: const Duration(milliseconds: 300),
            strokeWidth: 2,
            isCrossed: isCrossed,
            child: TextAtom(title, translate: translateTitle),
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
}

enum ListTileVariant {
  regular,
  strikethrough,
}
