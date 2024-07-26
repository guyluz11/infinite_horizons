import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/energy_level.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<IntroductionScreenState> _introKey =
      GlobalKey<IntroductionScreenState>();

  String workType = '';
  bool showNextButton = true;
  bool onTapReadyConfetti = false;
  IntroState state = IntroState.welcome;
  final Duration selectionTransitionDelay = const Duration(milliseconds: 200);

  void onIntroPageChange(int n) {
    state = IntroState.getStateByPageNumber(n);
    bool showNextButtonTemp = true;

    if (state == IntroState.workType &&
        (WorkTypeAbstract.instance?.tipType == null ||
            WorkTypeAbstract.instance!.tipType == TipType.undefined)) {
      showNextButtonTemp = false;
    } else if (state == IntroState.energy &&
        WorkTypeAbstract.instance!.getTimerStates().type ==
            EnergyType.undefined) {
      showNextButtonTemp = false;
    }
    setState(() {
      showNextButton = showNextButtonTemp;
    });
  }

  void nextPage() {
    VibrationController.instance.vibrate(VibrationType.light);
    _introKey.currentState?.next();
  }

  void onDone(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HomePage()));

  void previousPage() => _introKey.currentState?.previous();

  PageDecoration emptyPageDecoration() => const PageDecoration(
        pageMargin: EdgeInsets.zero,
        footerPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentMargin: EdgeInsets.only(bottom: 30),
      );

  PageViewModel customPageViewModel({required Widget bodyWidget}) =>
      PageViewModel(
        useScrollView: false,
        decoration: emptyPageDecoration(),
        bodyWidget: bodyWidget,
        titleWidget: const SizedBox(),
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return Scaffold(
      body: PopScope(
        canPop: state == IntroState.welcome,
        onPopInvoked: (_) {
          if (!onTapReadyConfetti) {
            previousPage();
          }
        },
        child: IntroductionScreen(
          isProgressTap: false,
          key: _introKey,
          dotsDecorator: DotsDecorator(
            color: colorScheme.outlineVariant,
            activeColor: colorScheme.primary,
          ),
          overrideNext: Center(
            child: ButtonAtom(
              variant: ButtonVariant.highEmphasisFilled,
              onPressed: showNextButton ? nextPage : () {},
              icon: FontAwesomeIcons.arrowRight,
              text: 'next',
              disabled: !showNextButton,
            ),
          ),
          overrideBack: Center(
            child: ButtonAtom(
              variant: ButtonVariant.lowEmphasisIcon,
              onPressed: previousPage,
              icon: FontAwesomeIcons.arrowLeft,
              disabled: !showNextButton,
            ),
          ),
          pages: [
            customPageViewModel(
              bodyWidget: WelcomeOrganism(),
            ),
            customPageViewModel(
              bodyWidget: WorkTypeSelectionMolecule(() async {
                setState(() {
                  workType = WorkTypeAbstract.instance!.tipType.name;
                });
                await Future.delayed(selectionTransitionDelay);
                nextPage();
              }),
            ),
            customPageViewModel(
              bodyWidget: TipsOrganism(workType),
            ),
            customPageViewModel(
              bodyWidget: EnergySelectionMolecule(() async {
                await Future.delayed(selectionTransitionDelay);
                nextPage();
              }),
            ),
            customPageViewModel(
              bodyWidget: ReadyForSessionPage(
                () => onDone(context),
                onTapReady: () {
                  setState(() => onTapReadyConfetti = true);
                },
              ),
            ),
          ],
          showBackButton: true,
          back: const Icon(Icons.arrow_back),
          next: const Icon(Icons.arrow_forward),
          scrollPhysics: const NeverScrollableScrollPhysics(),
          onChange: onIntroPageChange,
          showDoneButton: false,
          showNextButton: showNextButton,
        ),
      ),
    );
  }
}

enum IntroState {
  welcome(0),
  workType(1),
  tips(2),
  energy(3),
  encouragementSentence(4),
  ;

  const IntroState(this.pageNumber);

  final int pageNumber;

  static IntroState getStateByPageNumber(int number) {
    for (final IntroState state in IntroState.values) {
      if (state.pageNumber == number) {
        return state;
      }
    }
    return IntroState.welcome;
  }
}
