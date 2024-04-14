import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ListTileAtom extends StatelessWidget {
  const ListTileAtom(this.title, this.leading);

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextAtom(title),
      leading: leading,
    );
  }
}
