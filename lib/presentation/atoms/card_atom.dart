import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

class CardAtom extends StatelessWidget {
  const CardAtom({required this.child, this.image, this.imageColor});

  final Widget child;
  final Image? image;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          if (image != null)
            Container(
              height: 250,
              width: double.infinity,
              color: imageColor,
              child: image,
            ),
          Padding(
            padding: const EdgeInsets.all(AppThemeData.generalSpacing),
            child: child,
          ),
        ],
      ),
    );
  }
}
