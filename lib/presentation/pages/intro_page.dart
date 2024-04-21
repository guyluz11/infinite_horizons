import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppThemeData.generalSpacing),
        child: IntroductionScreen(
          key: _introKey,
          pages: [
            PageViewModel(
              title: 'Let’s Study Efficiently',
              bodyWidget: WelcomeOrganism(),
            ),
            PageViewModel(
              title: 'Study Type',
              bodyWidget: StudyTypeSelectionMolecule(() {
                setState(() {
                  studyType = StudyTypeAbstract.instance!.studyType.previewName;
                });
                nextPage();
              }),
            ),
            PageViewModel(
              title: 'Efficient $studyType Tips',
              bodyWidget: TipsOrganism(),
            ),
            PageViewModel(
              title: 'Energy',
              bodyWidget: EnergySelectionMolecule(nextPage),
            ),
            PageViewModel(
              title: 'Let’s Start',
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
                    StudyTypeAbstract.instance!.studyType ==
                        StudyType.undefined)) {
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
