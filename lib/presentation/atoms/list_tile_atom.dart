import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ListTileAtom extends StatelessWidget {
  const ListTileAtom(this.title, this.leading, {this.subtitle});

  final String title;
  final String? subtitle;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextAtom(title),
      subtitle: subtitle == null ? null : TextAtom(subtitle!),
      leading: leading,
    );
  }
}
