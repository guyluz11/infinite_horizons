import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ListTileAtom extends StatelessWidget {
  const ListTileAtom(
    this.title,
    this.leading, {
    this.subtitle,
    this.translateTitle = true,
    this.translateSubtitle = true,
  });

  final String title;
  final String? subtitle;
  final Widget leading;
  final bool translateTitle;
  final bool translateSubtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextAtom(title, translate: translateTitle),
      subtitle: subtitle == null
          ? null
          : TextAtom(subtitle!, translate: translateSubtitle),
      leading: leading,
    );
  }
}
