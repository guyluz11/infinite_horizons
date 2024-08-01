import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAtom extends StatefulWidget {
  const ConfettiAtom(this.controllerCenter);

  final ConfettiController controllerCenter;

  @override
  State<ConfettiAtom> createState() => _ConfettiAtomState();
}

class _ConfettiAtomState extends State<ConfettiAtom> {
  @override
  void dispose() {
    widget.controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return ConfettiWidget(
      confettiController: widget.controllerCenter,
      blastDirectionality: BlastDirectionality.explosive,
      createParticlePath: drawStar,
      numberOfParticles: 50,
      colors: [
        /// Primary
        colorScheme.primary,
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        colorScheme.primaryFixed,
        colorScheme.primaryFixedDim,
        colorScheme.onPrimaryFixed,
        colorScheme.onPrimaryFixedVariant,

        /// Secondary
        colorScheme.secondary,
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
        colorScheme.secondaryFixed,
        colorScheme.secondaryFixedDim,
        colorScheme.onSecondaryFixed,
        colorScheme.onSecondaryFixedVariant,

        /// Tertiary
        colorScheme.tertiary,
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
        colorScheme.tertiaryFixed,
        colorScheme.tertiaryFixedDim,
        colorScheme.onTertiaryFixed,
        colorScheme.onTertiaryFixedVariant,

        /// Surface
        colorScheme.surfaceContainerHighest,
        colorScheme.onSurface,
        colorScheme.onSurfaceVariant,
      ],
    );
  }
}
