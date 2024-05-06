import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/home_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<IntroductionScreenState> _introKey =
      GlobalKey<IntroductionScreenState>();

  String studyType = '';
  bool showNextButton = true;
  IntroState state = IntroState.welcome;

  void nextPage() {
    _introKey.currentState?.next();
  }

  void onDone(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HomePage()));

  PageDecoration emptyPageDecoration() => const PageDecoration(
        pageMargin: EdgeInsets.zero,
        footerPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentMargin: EdgeInsets.zero,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: _introKey,
        pages: [
          PageViewModel(
            useScrollView: false,
            decoration: emptyPageDecoration(),
            bodyWidget: WelcomeOrganism(),
            titleWidget: const SizedBox(),
          ),
          PageViewModel(
            titleWidget: const SizedBox(),
            decoration: emptyPageDecoration(),
            bodyWidget: StudyTypeSelectionMolecule(() {
              setState(() {
                studyType = StudyTypeAbstract.instance!.studyType.name;
              });
              nextPage();
            }),
          ),
          PageViewModel(
            titleWidget: const SizedBox(),
            decoration: emptyPageDecoration(),
            bodyWidget: TipsOrganism(nextPage, studyType),
          ),
          PageViewModel(
            titleWidget: const SizedBox(),
            decoration: emptyPageDecoration(),
            bodyWidget: EnergySelectionMolecule(nextPage),
          ),
          PageViewModel(
            titleWidget: const SizedBox(),
            useScrollView: false,
            decoration: emptyPageDecoration(),
            bodyWidget: MotivationOrganism(() => onDone(context)),
          ),
        ],
        showBackButton: true,
        back: const Icon(Icons.arrow_back),
        next: const Icon(Icons.arrow_forward),
        showNextButton: showNextButton,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        onChange: (int n) {
          state = IntroState.getStateByPageNumber(n);
          bool showNextButtonTemp = true;

          if (state == IntroState.studyType &&
              (StudyTypeAbstract.instance?.studyType == null ||
                  StudyTypeAbstract.instance!.studyType == TipType.undefined)) {
            showNextButtonTemp = false;
          } else if (state == IntroState.energy &&
              StudyTypeAbstract.instance!.energy == EnergyType.undefined) {
            showNextButtonTemp = false;
          }
          setState(() {
            showNextButton = showNextButtonTemp;
          });
        },
        showDoneButton: false,
      ),
    );
  }
}

enum IntroState {
  welcome(0),
  studyType(1),
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
