import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

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
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool translateTitle;
  final bool translateSubtitle;
  final VoidCallback? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enable,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      minLeadingWidth: 0,
      title: TextAtom(title, translate: translateTitle),
      subtitle: subtitle == null
          ? null
          : TextAtom(subtitle!, translate: translateSubtitle),
      leading: leading != null
          ? Container(
              margin: const EdgeInsets.only(right: AppThemeData.generalSpacing),
              child: leading,
            )
          : null,
      trailing: trailing != null
          ? Container(
              margin: const EdgeInsets.only(left: AppThemeData.generalSpacing),
              child: trailing,
            )
          : null,
      onTap: onTap,
    );
  }
}
