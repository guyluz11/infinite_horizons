import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

class MarginedExpandedAtom extends StatelessWidget {
  const MarginedExpandedAtom({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: GlobalVariables.maxWidth,
        margin: AppThemeData.generalHorizontalEdgeInsets,
        child: child,
      ),
    );
  }
}
