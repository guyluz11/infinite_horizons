import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeState state = HomeState.getReadyForStudy;
  // TODO: save toggled state for next time
  bool lockScreen = true;

  @override
  void initState() {
    super.initState();
    if (lockScreen) {
      WakeLockController.instance.setWakeLock(true);
    }
  }

  @override
  void dispose() {
    WakeLockController.instance.setWakeLock(false);
    super.dispose();
  }

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
        PlayerController.instance.play('start_session.wav');
        VibrationController.instance.vibrate(VibrationType.heavy);
        return TimerOrganism(TimerVariant.study, onComplete: onTimerComplete);
      case HomeState.getReadyForBreak:
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeBreak,
          onComplete: onTimerComplete,
        );
      case HomeState.breakTime:
        return TimerOrganism(
          TimerVariant.breakTime,
          onComplete: onTimerComplete,
        );
      case HomeState.getReadyForStudy:
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeStudy,
          onComplete: onTimerComplete,
        );
    }
  }

  void secondaryButtonOnTap(BuildContext context) {
    final Widget body = Column(
      children: [
        ToggleButtonMolecule(
          text: 'Sound',
          offIcon: Icons.music_off_rounded,
          onIcon: Icons.music_note_rounded,
          onChange: (bool value) =>
              PlayerController.instance.setSilentState(!value),
          initialValue: PlayerController.instance.getSilentState(),
        ),
        ToggleButtonMolecule(
          text: 'Screen Lock',
          offIcon: Icons.lock_clock,
          onIcon: Icons.lock_open,
          onChange: (bool value) {
            lockScreen = value;
            WakeLockController.instance.setWakeLock(lockScreen);
          },
          initialValue: lockScreen,
        ),
      ],
    );

    openAlertDialog(context, body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MarginedExpandedAtom(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TopBarMolecule(
              title: 'study_efficiency',
              topBarType: TopBarType.none,
              secondaryButtonOnTap: () => secondaryButtonOnTap(context),
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
            Expanded(
              child: stateWidget(),
            ),
          ],
        ),
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
