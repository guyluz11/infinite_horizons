import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/objects/energy_level.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage(this.tipType);

  final TipType tipType;

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<IntroductionScreenState> _introKey =
      GlobalKey<IntroductionScreenState>();

  bool showBackButton = true;
  bool showNextButton = true;
  bool isFinish = false;
  IntroState state = IntroState.tips;
  final Duration selectionTransitionDelay = const Duration(milliseconds: 200);

  void onNextPressed() {
    isFinish = true;
    setState(() {
      showBackButton = false;
    });
  }

  void onIntroPageChange(int n) {
    state = IntroState.getStateByPageNumber(n);
    bool showNextButtonTemp = true;

    if (state == IntroState.energy &&
        WorkTypeAbstract.instance!.getTimerStates().type ==
            EnergyType.undefined) {
      showNextButtonTemp = false;
    }
    setState(() {
      showNextButton = showNextButtonTemp;
    });
  }

  void nextPage() => _introKey.currentState?.next();

  void onDone() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ActivityPage()));

  void previousPage() {
    if (isFinish) {
      return;
    }
    _introKey.currentState?.previous();
  }

  void onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) {
      return; // user have just tapped on screen (no dragging)
    } else if (details.primaryVelocity!.compareTo(0) == -1) {
      if (showNextButton) {
        nextPage();
      }
      return;
    }
    previousPage();
  }

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
        canPop: state == IntroState.tips,
        onPopInvokedWithResult: (bool a, b) => previousPage(),
        child: GestureDetector(
          onHorizontalDragEnd: onHorizontalDrag,
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
                bodyWidget: TipsOrganism(widget.tipType),
              ),
              customPageViewModel(
                bodyWidget: EnergySelectionMolecule(() async {
                  await Future.delayed(selectionTransitionDelay);
                  nextPage();
                }),
              ),
              customPageViewModel(
                bodyWidget: ReadyForSessionPage(
                  onDone: onDone,
                  onNextPressed: onNextPressed,
                ),
              ),
            ],
            showBackButton: showBackButton,
            back: const Icon(Icons.arrow_back),
            next: const Icon(Icons.arrow_forward),
            scrollPhysics: const NeverScrollableScrollPhysics(),
            onChange: onIntroPageChange,
            showDoneButton: false,
            showNextButton: showNextButton,
          ),
        ),
      ),
    );
  }
}

enum IntroState {
  tips(0),
  energy(1),
  encouragementSentence(2),
  ;

  const IntroState(this.pageNumber);

  final int pageNumber;

  static IntroState getStateByPageNumber(int number) {
    for (final IntroState state in IntroState.values) {
      if (state.pageNumber == number) {
        return state;
      }
    }
    return IntroState.tips;
  }
}
