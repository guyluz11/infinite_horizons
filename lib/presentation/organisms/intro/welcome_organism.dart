import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class WelcomeOrganism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MarginedExpandedAtom(
        child: Column(
          children: [
            const TopBarMolecule(
              topBarType: TopBarType.none,
              title: 'study_efficiently',
              margin: false,
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
            const TextAtom(
              "About the app:\n"
              "Sometimes we study new material but can't remember as much as we would like to.\n"
              "Sometimes we work but our focus isn't as strong as we know it could be.\nUsing this app your study and work session efficiency can increase dramatically by following methods that got approved by studies and published in research papers.\n\n"
              "Instructions:\nEach time you sit to study a new material or work in your office we recommend opening the app and let it guid you for efficient and productive session.\n"
              "The app use your responses to tailor the tips and session timer to your specific needs, so make sure to follow it as best as you can.\n\n"
              "Enjoy",
            ),
            const SeparatorAtom(),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppThemeData.logoBackgroundColor,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            const SeparatorAtom(),
          ],
        ),
      ),
    );
  }
}
