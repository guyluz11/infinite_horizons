import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class StrikethroughTileAtom extends StatelessWidget {
  const StrikethroughTileAtom(
    this.title, {
    this.trailing,
    this.leading,
    this.subtitle,
    this.translateTitle = true,
    this.translateSubtitle = true,
    this.onTap,
    this.enable = true,
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
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enable,
      contentPadding: EdgeInsets.zero,
      title: AnimatedLineThrough(
          duration: const Duration(milliseconds: 300),
          strokeWidth: 2,
          isCrossed: isCrossed,
          child: TextAtom(title, translate: translateTitle),),
      subtitle: subtitle == null
          ? null
          : TextAtom(subtitle!, translate: translateSubtitle),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
