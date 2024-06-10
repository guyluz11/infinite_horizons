import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/background_service_controller.dart';
import 'package:infinite_horizons/domain/energy_level.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/infrastructure/core/logger.dart';
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

  static Duration getRemainingTime() => _remainingTime;
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
  @override
  State<TimerOrganism> createState() => _TimerOrganismState();
}

class _TimerOrganismState extends State<TimerOrganism>
    with WidgetsBindingObserver {
  TimerState state = TimerStateManager.state;

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
  Future didChangeAppLifecycleState(AppLifecycleState appState) async {
    switch (appState) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        return;
      case AppLifecycleState.resumed:
        BackgroundServiceController.instance.stopService();
        await PreferencesController.instance.reload();
        final TimerState state = TimerStateExtension.fromString(
          PreferencesController.instance.getString('timerState') ?? '',
        );
        logger.i('App resumed with timerState $state');
        TimerStateManager.state = state;

        final Duration remainingTime =
            PreferencesController.instance.getDuration('remainingTimerTime') ??
                Duration.zero;
        TimerStateManager.iterateOverTimerStates(remainingTime: remainingTime);
        setCurrentState();
        return;
      case AppLifecycleState.paused:
        TimerStateManager.pauseTimer();
        await BackgroundServiceController.instance.startService();
        PreferencesController.instance.setDuration(
          'remainingTimerTime',
          TimerStateManager.getRemainingTime(),
        );

        PreferencesController.instance
            .setString('tipType', StudyTypeAbstract.instance!.tipType.name);

        BackgroundServiceController.instance.startIterateTimerStates(
          StudyTypeAbstract.instance!.tipType,
          StudyTypeAbstract.instance!.getTimerStates().type,
          state,
          TimerStateManager.getRemainingTime(),
        );
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
      case TimerState.study:
      case TimerState.breakTime:
        return TimerMolecule(
          () {},
          TimerStateManager.getTimerDuration(),
        );
      case TimerState.getReadyForBreak:
        return ProgressIndicatorMolecule(onComplete: () {});
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
