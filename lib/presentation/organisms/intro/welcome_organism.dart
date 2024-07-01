import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class WelcomeOrganism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      scaffold: false,
      title: 'study_efficiently',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardAtom(
                image: Image.asset('assets/logo.png'),
                imageColor: AppThemeData.logoBackgroundColor,
                child: const Column(
                  children: [
                    SeparatorAtom(),
                    TextAtom(
                      'About the app',
                      variant: TextVariant.smallTitle,
                    ),
                    SeparatorAtom(variant: SeparatorVariant.relatedElements),
                    TextAtom(
                        "Sometimes we study new material but can't remember as much as we would like to.\n"
                        "Sometimes we work but our focus isn't as strong as we know it could be.\nUsing this app your study and work session efficiency can increase dramatically by following methods that got approved by studies and published in research papers.\n"),
                    TextAtom('Instructions', variant: TextVariant.smallTitle),
                    SeparatorAtom(variant: SeparatorVariant.relatedElements),
                    TextAtom(
                      "Each time you sit to study a new material or work in your office we recommend opening the app and let it guide you for efficient and productive session.\n"
                      "The app use your responses to tailor the tips and session timer to your specific needs, so make sure to follow it as best as you can.\n\n"
                      "Enjoy",
                    ),
                  ],
                ),
              ),
              const SeparatorAtom(),
            ],
          ),
        ),
      ),
    );
  }
}
