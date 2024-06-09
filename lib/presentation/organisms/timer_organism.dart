import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/background_service_controller.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/timer_states.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TimerStateManager {
  static HomeState state = HomeState.study;
  static TimerStates timerStates = StudyTypeAbstract.instance!.getTimerStates();
  static Duration getReadyDuration = const Duration(seconds: 10);
  static Timer? _timer;
  static VoidCallback? callback;

  static void incrementState() {
    switch (state) {
      case HomeState.study:
        state = HomeState.getReadyForBreak;
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
      case HomeState.getReadyForBreak:
        state = HomeState.breakTime;
      case HomeState.breakTime:
        state = HomeState.readyToStart;
        PlayerController.instance.play('break_ended.wav');
      case HomeState.readyToStart:
        timerStates.promoteSession();
        PlayerController.instance.play('start_session.wav');
        VibrationController.instance.vibrate(VibrationType.heavy);
        state = HomeState.study;
    }
  }

  static Duration getTimerDuration() {
    switch (state) {
      case HomeState.study:
        return timerStates.getCurrentSession().study;
      case HomeState.getReadyForBreak:
        return getReadyDuration;
      case HomeState.breakTime:
        return timerStates.getCurrentSession().breakDuration;
      case HomeState.readyToStart:
        return Duration.zero;
    }
  }

  int? getTime() => _timer?.tick;

  static Future iterateOverTimerStates() async {
    final Duration stateDuration = getTimerDuration();
    if (stateDuration == Duration.zero) {
      return;
    }

    _timer = Timer(
      stateDuration,
      () {
        incrementState();
        callback?.call();
        TimerStateManager.iterateOverTimerStates();
      },
    );
  }
}

class TimerOrganism extends StatefulWidget {
  @override
  State<TimerOrganism> createState() => _TimerOrganismState();
}

class _TimerOrganismState extends State<TimerOrganism>
    with WidgetsBindingObserver {
  HomeState state = TimerStateManager.state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final PreferencesController prefs = PreferencesController.instance;
    final bool lockScreen = prefs.getBool("isLockScreen") ?? true;
    WakeLockController.instance.setWakeLock(lockScreen);
    PlayerController.instance.setIsSound(prefs.getBool("isSound") ?? true);

    if (lockScreen) {
      WakeLockController.instance.setWakeLock(true);
    }
    PlayerController.instance.play('start_session.wav');
    VibrationController.instance.vibrate(VibrationType.heavy);
    TimerStateManager.callback = setCurrentState;
    TimerStateManager.iterateOverTimerStates();
  }

  @override
  void dispose() {
    WakeLockController.instance.setWakeLock(false);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        return;
      case AppLifecycleState.paused:
        BackgroundServiceController.instance.startIterateTimerStates();
        return;
    }
  }

  void setCurrentState() {
    setState(() {
      state = TimerStateManager.state;
    });
  }

  Widget stateWidget() {
    switch (state) {
      case HomeState.study:
      case HomeState.breakTime:
        return TimerMolecule(
          () {},
          TimerStateManager.getTimerDuration(),
        );
      case HomeState.getReadyForBreak:
        return ProgressIndicatorMolecule(onComplete: () {});
      case HomeState.readyToStart:
        return ReadyForSessionOrganism(() {
          TimerStateManager.incrementState();
          TimerStateManager.iterateOverTimerStates();
          setCurrentState();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
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
