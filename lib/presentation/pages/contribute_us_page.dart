import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class ContributeUsPage extends StatelessWidget {
  void continueOnPressed(BuildContext context) {
    PreferencesController.instance
        .setBool(PreferenceKeys.finishedIntroduction, true);

    Navigator.of(context).pop();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

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
                  TextAtom(
                    'Open App',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.white),
                  ),
                  const SeparatorAtom(),
                  const SeparatorAtom(),
                  TextAtom(
                    'The app is open source and intended to be collaborative effort.',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SeparatorAtom(),
                  const SeparatorAtom(),
                  TextAtom(
                    'If you have any suggestions and want to contribute feel free to join us at the following links.',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SeparatorAtom(),
                  const SeparatorAtom(),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            ButtonAtom(
                              text: 'GitHub',
                              variant: ButtonVariant.mediumEmphasisOutlined,
                              onPressed: () =>
                                  WebBrowserController.instance.lunchLink(
                                'https://github.com/guyluz11/infinite_horizons',
                              ),
                              icon: FontAwesomeIcons.github,
                              onBlueBackground: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            ButtonAtom(
                              variant: ButtonVariant.mediumEmphasisOutlined,
                              text: 'Contact Us',
                              onPressed: () =>
                                  WebBrowserController.instance.lunchLink(
                                'https://github.com/guyluz11/infinite_horizons/issues',
                              ),
                              icon: FontAwesomeIcons.message,
                              onBlueBackground: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            ButtonAtom(
              variant: ButtonVariant.highEmphasisFilled,
              onPressed: () => continueOnPressed(context),
              text: 'Finish Intro',
            ),
            const SeparatorAtom(),
            const SafeArea(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
