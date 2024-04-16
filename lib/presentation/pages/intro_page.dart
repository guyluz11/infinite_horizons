import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
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

  void nextPage() {
    // TODO: Hide next button for sertan pages until element get selected
    _introKey.currentState?.next();
  }

  void onDone(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HomePage()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
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
            title: 'Efficient $studyType Study',
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
        showDoneButton: false,
      ),
    );
  }
}
