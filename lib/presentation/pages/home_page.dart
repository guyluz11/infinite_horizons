import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeState state = HomeState.study;
  final Duration getReadyDuration = const Duration(seconds: 10);
  final int breakTimeRatio = 5;

  void onTimerComplete() {
    HomeState nextState;
    switch (state) {
      case HomeState.study:
        nextState = HomeState.getReadyForBreak;
      case HomeState.getReadyForBreak:
        nextState = HomeState.breakTime;
      case HomeState.breakTime:
        nextState = HomeState.getReadyForStudy;
      case HomeState.getReadyForStudy:
        nextState = HomeState.study;
    }

    setState(() {
      state = nextState;
    });
  }

  Widget stateWidget() {
    switch (state) {
      case HomeState.study:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextAtom('Study'),
            TimerMolecule(
              onTimerComplete,
              StudyTypeAbstract.instance!.energy.duration,
            ),
          ],
        );
      case HomeState.getReadyForBreak:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextAtom('Get ready for a break'),
            ProgressIndicatorAtom(getReadyDuration, onTimerComplete),
          ],
        );
      case HomeState.breakTime:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextAtom('Take a break'),
            TimerMolecule(
              onTimerComplete,
              Duration(
                milliseconds: StudyTypeAbstract
                        .instance!.energy.duration.inMilliseconds ~/
                    breakTimeRatio,
              ),
            ),
          ],
        );
      case HomeState.getReadyForStudy:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextAtom('Get ready to study'),
            ProgressIndicatorAtom(getReadyDuration, onTimerComplete),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextAtom('Maximize Study Efficiency'),
          Expanded(
            child: stateWidget(),
          ),
        ],
      ),
    );
  }
}

enum HomeState {
  study,
  getReadyForBreak,
  breakTime,
  getReadyForStudy,
  ;
}
