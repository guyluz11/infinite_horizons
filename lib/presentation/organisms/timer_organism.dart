import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/energy_level.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TimerStateManager {
  static TimerState state = TimerState.study;
  static EnergyLevel timerStates = StudyTypeAbstract.instance!.getTimerStates();
  static Duration getReadyDuration = const Duration(seconds: 10);
  static Timer? _timer;
  static VoidCallback? callback;
  static Duration _remainingTime = Duration.zero;

  static void incrementState() {
    switch (state) {
      case TimerState.study:
        state = TimerState.getReadyForBreak;
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
      case TimerState.getReadyForBreak:
        state = TimerState.breakTime;
      case TimerState.breakTime:
        state = TimerState.readyToStart;
        PlayerController.instance.play('break_ended.wav');
      case TimerState.readyToStart:
        timerStates.promoteSession();
        PlayerController.instance.play('start_session.wav');
        VibrationController.instance.vibrate(VibrationType.heavy);
        state = TimerState.study;
    }
  }

  static Duration getTimerDuration() {
    switch (state) {
      case TimerState.study:
        return timerStates.getCurrentSession().study;
      case TimerState.getReadyForBreak:
        return getReadyDuration;
      case TimerState.breakTime:
        return timerStates.getCurrentSession().breakDuration;
      case TimerState.readyToStart:
        return Duration.zero;
    }
  }

  static Duration? getRemainingTime() =>
      _remainingTime == Duration.zero ? null : _remainingTime;

  static void pauseTimer() => _timer?.cancel();

  static Future iterateOverTimerStates({Duration? remainingTime}) async {
    final Duration stateDuration = remainingTime ?? getTimerDuration();
    if (stateDuration == Duration.zero) {
      return;
    }

    _remainingTime = stateDuration;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_remainingTime <= const Duration(seconds: 1)) {
          _remainingTime = Duration.zero;
          _timer?.cancel();
          incrementState();
          callback?.call();
          iterateOverTimerStates();
          return;
        }
        _remainingTime = _remainingTime - const Duration(seconds: 1);
      },
    );
  }
}

class TimerOrganism extends StatefulWidget {
  const TimerOrganism({super.key});

  @override
  State<TimerOrganism> createState() => TimerOrganismState();
}

class TimerOrganismState extends State<TimerOrganism> {
  TimerState state = TimerStateManager.state;

  @override
  void initState() {
    super.initState();
    final PreferencesController prefs = PreferencesController.instance;
    final bool lockScreen = prefs.getBool("isLockScreen") ?? true;
    WakeLockController.instance.setWakeLock(lockScreen);
    PlayerController.instance.setIsSound(prefs.getBool("isSound") ?? true);

    if (lockScreen) {
      WakeLockController.instance.setWakeLock(true);
    }
    TimerStateManager.callback = setCurrentState;
  }

  @override
  void dispose() {
    WakeLockController.instance.setWakeLock(false);
    super.dispose();
  }

  void setCurrentState() {
    setState(() {
      state = TimerStateManager.state;
    });
  }

  Widget stateWidget() {
    switch (state) {
      case TimerState.study:
      case TimerState.breakTime:
        return TimerMolecule(
          () {},
          TimerStateManager.getTimerDuration(),
          initialValue: TimerStateManager.getRemainingTime(),
        );
      case TimerState.getReadyForBreak:
        final Duration totalTime = TimerStateManager.getReadyDuration;
        final Duration timePassed =
            totalTime - (TimerStateManager.getRemainingTime() ?? totalTime);
        return ProgressIndicatorMolecule(
          duration: totalTime,
          onComplete: () {},
          initialValue: timePassed,
        );
      case TimerState.readyToStart:
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
      case TimerState.study:
        title = 'study_timer';
      case TimerState.getReadyForBreak:
        title = 'ready_for_break';
      case TimerState.breakTime:
        title = 'take_break';
      case TimerState.readyToStart:
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

enum TimerState {
  study,
  getReadyForBreak,
  breakTime,
  readyToStart,
  ;
}

extension TimerStateExtension on TimerState {
  static TimerState fromString(String typeAsString) {
    return TimerState.values.firstWhere(
      (element) => element.toString().split('.').last == typeAsString,
      orElse: () => TimerState.values.first,
    );
  }
}
