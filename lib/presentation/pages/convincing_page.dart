import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/home_page.dart';

class ConvincingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppThemeData.logoBackgroundColor,
        child: Column(
          children: [
            const TopBarMolecule(topBarType: TopBarType.none, margin: false),
            MarginedExpandedAtom(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: double.infinity),
                    TextAtom(
                      'The app will',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Colors.white),
                    ),
                    SeparatorAtom(),
                    SeparatorAtom(),
                    TextAtom(
                      '* Organize your breaks',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    SeparatorAtom(),
                    TextAtom(
                      '* Enrich you with efficiency tips',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    SeparatorAtom(),
                    TextAtom(
                      '* Encourage healthy habits',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Text('')),
            SafeArea(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 2),
                child: ButtonAtom(
                  variant: ButtonVariant.highEmphasisFilled,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  text: 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
