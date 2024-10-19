import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.infinity),
                  AnimatedTextAtom(
                    text: 'The app will',
                    variant: AnimatedTextVariant.flicker,
                    onDone: () {},
                    textColorWhite: true,
                  ),
                  const SeparatorAtom(),
                  const SeparatorAtom(),
                  TextAtom(
                    '* Organize your breaks',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SeparatorAtom(),
                  TextAtom(
                    '* Enrich you with efficiency tips',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SeparatorAtom(),
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
            const Expanded(child: Text('')),
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: ButtonAtom(
                variant: ButtonVariant.highEmphasisFilled,
                onPressed: () {
                  PreferencesController.instance
                      .setBool(PreferenceKeys.finishedIntroduction, true);

                  Navigator.of(context).pop();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                text: 'Home Page',
              ),
            ),
            const SeparatorAtom(),
            const SafeArea(
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
