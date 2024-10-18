import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/convincing_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showSubTitle = false;
  double buttonOpacity = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      showSubTitle = true;
    });
  }

  Future animatedTextFinish() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      buttonOpacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppThemeData.logoBackgroundColor,
        child: Column(
          children: [
            const TopBarMolecule(topBarType: TopBarType.none, margin: false),
            TextAtom(
              AppThemeData.appName,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
            ),
            const SeparatorAtom(variant: SeparatorVariant.relatedElements),
            if (showSubTitle)
              AnimatedTextAtom(
                text: 'Improves productivity',
                variant: AnimatedTextVariant.typewriter,
                onDone: animatedTextFinish,
                textColorWhite: true,
              )
            else
              const TextAtom('', variant: TextVariant.title),
            const ImageAtom(
              'assets/logo.png',
              hero: 'full_logo',
            ),
            const SeparatorAtom(),
            const Expanded(child: Text('')),
            SafeArea(
              child: AnimatedOpacity(
                opacity: buttonOpacity,
                duration: const Duration(seconds: 2),
                child: ButtonAtom(
                  variant: ButtonVariant.highEmphasisFilled,
                  onPressed: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConvincingPage(),
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
