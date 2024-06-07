import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/timer_states.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TimerOrganism extends StatefulWidget {
  @override
  State<TimerOrganism> createState() => _TimerOrganismState();
}

class _TimerOrganismState extends State<TimerOrganism>
    with AutomaticKeepAliveClientMixin<TimerOrganism> {
  HomeState state = HomeState.study;
  late TimerStates timerStates;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final PreferencesController prefs = PreferencesController.instance;
    final bool lockScreen = prefs.getBool("isLockScreen") ?? true;
    WakeLockController.instance.setWakeLock(lockScreen);
    PlayerController.instance.setIsSound(prefs.getBool("isSound") ?? true);
    timerStates = StudyTypeAbstract.instance!.getTimerStates();

    if (lockScreen) {
      WakeLockController.instance.setWakeLock(true);
    }
    PlayerController.instance.play('start_session.wav');
    VibrationController.instance.vibrate(VibrationType.heavy);
  }

  @override
  void dispose() {
    WakeLockController.instance.setWakeLock(false);
    super.dispose();
  }

  void setNextState() {
    HomeState nextState;
    switch (state) {
      case HomeState.study:
        nextState = HomeState.getReadyForBreak;
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
      case HomeState.getReadyForBreak:
        nextState = HomeState.breakTime;
      case HomeState.breakTime:
        nextState = HomeState.readyToStart;
        PlayerController.instance.play('break_ended.wav');
      case HomeState.readyToStart:
        timerStates.promoteSession();
        PlayerController.instance.play('start_session.wav');
        VibrationController.instance.vibrate(VibrationType.heavy);
        nextState = HomeState.study;
    }
    setState(() {
      state = nextState;
    });
  }

  Widget stateWidget() {
    switch (state) {
      case HomeState.study:
        return TimerMolecule(
          setNextState,
          timerStates.getCurrentSession().study,
        );
      case HomeState.getReadyForBreak:
        return ProgressIndicatorMolecule(onComplete: setNextState);
      case HomeState.breakTime:
        return TimerMolecule(
          setNextState,
          timerStates.getCurrentSession().breakDuration,
        );
      case HomeState.readyToStart:
        return ReadyForSessionOrganism(setNextState);
    }
  }

  void settingsOnComplete() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String title;
    switch (state) {
      case HomeState.study:
        title = 'study_timer';
      case HomeState.getReadyForBreak:
        title = 'ready_for_break';
      case HomeState.breakTime:
        title = 'take_break';
      case HomeState.readyToStart:
        title = 'ready_for_session';
    }

    return PageEnclosureMolecule(
      title: title,
      scaffold: false,
      expendChild: false,
      topBarRightOnTap: () => openAlertDialog(context, SettingsPage()),
      child: stateWidget(),
    );
  }
}

enum HomeState {
  study,
  getReadyForBreak,
  breakTime,
  readyToStart,
  ;
}
