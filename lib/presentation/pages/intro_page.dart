import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/home_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Let’s Study Efficiently',
            bodyWidget: WelcomeOrganism(),
          ),
          PageViewModel(
            title: 'Study Type',
            bodyWidget: StudyTypeOrganism(),
          ),
          PageViewModel(
            title: 'Efficient Creativity study',
            bodyWidget: TipsOrganism(),
          ),
          PageViewModel(
            title: 'Energy',
            bodyWidget: EnergyOrganism(),
          ),
          PageViewModel(
            title: 'Let’s Start',
            bodyWidget: MotivationOrganism(),
          ),
        ],
        onDone: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
