import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/energy_level.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/progress_tracker_atom.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TimerStateManager {
  static TimerState state = TimerState.work;
  static EnergyLevel timerStates = WorkTypeAbstract.instance!.getTimerStates();

  static Timer? _timer;
  static VoidCallback? callback;
  static Duration _remainingTime = Duration.zero;

  static void incrementState() {
    state = getNextState(state);
    switch (state) {
      case TimerState.work:
        timerStates.promoteSession();
        PlayerController.instance.play(SoundType.startSession);
        VibrationController.instance.vibrate(VibrationType.heavy);
      case TimerState.getReadyForBreak:
        PlayerController.instance.play(SoundType.sessionCompleted);
        VibrationController.instance.vibrate(VibrationType.medium);
      case TimerState.breakTime:
        break;
      case TimerState.readyToStart:
        PlayerController.instance.play(SoundType.breakEnded);
    }
  }

  static TimerState getNextState(TimerState state) {
    switch (state) {
      case TimerState.work:
        return TimerState.getReadyForBreak;
      case TimerState.getReadyForBreak:
        return TimerState.breakTime;
      case TimerState.breakTime:
        return TimerState.readyToStart;
      case TimerState.readyToStart:
        return TimerState.work;
    }
  }

  static Duration getTimerDuration(TimerState state) {
    switch (state) {
      case TimerState.work:
        return timerStates.getCurrentSession().work;
      case TimerState.getReadyForBreak:
        return timerStates.getCurrentSession().getReadyForBreak;
      case TimerState.breakTime:
        return timerStates.getCurrentSession().breakDuration;
      case TimerState.readyToStart:
        return Duration.zero;
    }
  }

  static Duration? get remainingTime =>
      _remainingTime <= Duration.zero ? null : _remainingTime;

  static set remainingTime(Duration? value) =>
      _remainingTime = value ?? Duration.zero;

  static void pauseTimer() => _timer?.cancel();

  static bool isTimerRunning() => _timer != null && _timer!.isActive;

  static Future iterateOverTimerStates({Duration? remainingTime}) async {
    final Duration stateDuration = remainingTime ?? getTimerDuration(state);
    if (stateDuration == Duration.zero) {
      return;
    }

    _remainingTime = stateDuration;

    const Duration interval = Duration(seconds: 1);

    _timer = Timer.periodic(
      interval,
      (Timer timer) {
        if (_remainingTime <= interval) {
          _remainingTime = Duration.zero;
          _timer?.cancel();
          incrementState();
          callback?.call();
          iterateOverTimerStates();
          return;
        }
        _remainingTime = _remainingTime - interval;
      },
    );
  }

  static List<UpcomingState> getAllStates() {
    final List<UpcomingState> upcomingStates = [];
    TimerState tempState = TimerState.values.first;
    Duration durationForState = getTimerDuration(tempState);
    final DateTime now = DateTime.now();

    while (durationForState != Duration.zero) {
      final UpcomingState upcomingState =
          UpcomingState(tempState, now, durationForState);
      upcomingStates.add(upcomingState);
      tempState = getNextState(tempState);
      durationForState = getTimerDuration(tempState);
    }
    upcomingStates.add(UpcomingState(tempState, now, durationForState));

    return upcomingStates;
  }

  static List<UpcomingState> upcomingStates(
    TimerState fromState,
    Duration? remainingTimeForState, {
    DateTime? calculateFromDate,
  }) {
    final List<UpcomingState> statesWithTime = [];

    Duration durationForState = remainingTimeForState ?? Duration.zero;

    DateTime endTime = calculateFromDate ?? DateTime.now();
    TimerState tempState = fromState;

    while (durationForState != Duration.zero) {
      endTime = endTime.add(durationForState);
      statesWithTime.add(UpcomingState(tempState, endTime, durationForState));
      tempState = getNextState(tempState);
      durationForState = getTimerDuration(tempState);
    }
    endTime = endTime.add(durationForState);
    statesWithTime.add(UpcomingState(tempState, endTime, durationForState));

    return statesWithTime;
  }
}

/// Class representing an upcoming timer state with its corresponding time.
class UpcomingState {
  UpcomingState(this.state, this.endTime, this.duration);

  final TimerState state;
  final DateTime endTime;
  final Duration duration;

  DateTime startTime() => endTime.subtract(duration);
}

class TimerOrganism extends StatefulWidget {
  const TimerOrganism({super.key});

  @override
  State<TimerOrganism> createState() => TimerOrganismState();
}

class TimerOrganismState extends State<TimerOrganism> {
  TimerState state = TimerStateManager.state;
  bool renderSizedBox = false;

  void onComplete() {
    TimerStateManager.incrementState();
    TimerStateManager.iterateOverTimerStates();
    setCurrentState();
  }

  @override
  void initState() {
    super.initState();
    final bool lockScreen =
        PreferencesController.instance.getBool(PreferenceKeys.isLockScreen) ??
            true;
    WakeLockController.instance.setWakeLock(lockScreen);

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

  Future setCurrentState() async {
    if (state == TimerState.work &&
        TimerStateManager.state == TimerState.breakTime) {
      setState(() {
        renderSizedBox = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          renderSizedBox = false;
          state = TimerStateManager.state;
        });
      });
      return;
    }

    setState(() {
      renderSizedBox = false;
      state = TimerStateManager.state;
    });
  }

  Widget stateWidget() {
    switch (state) {
      case TimerState.work:
      case TimerState.breakTime:
        return TimerMolecule(
          duration: TimerStateManager.getTimerDuration(state),
          initialValue: TimerStateManager.remainingTime,
        );
      case TimerState.getReadyForBreak:
        final Duration totalTime = TimerStateManager.getTimerDuration(state);
        final Duration timePassed =
            totalTime - (TimerStateManager.remainingTime ?? totalTime);
        return ProgressIndicatorMolecule(
          duration: totalTime,
          initialValue: timePassed,
        );
      case TimerState.readyToStart:
        return ReadyForSessionOrganism(
          onComplete: onComplete,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch (state) {
      case TimerState.work:
        title = 'work_timer';
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
      topMargin: false,
      rightPopupMenu: <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          value: SampleItem.first,
          child: const Text('Navigate Home'),
          onTap: () => backToHomePopup(context),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.second,
          child: const Text('Settings'),
          onTap: () => openAlertDialog(context, SettingsPage()),
        ),
      ],
      child: Column(
        children: [
          ProgressTrackerAtom(
            TimerStateManager.getAllStates(),
            state,
            TimerStateManager.timerStates.sessions.length - 1 ==
                TimerStateManager.timerStates.currentState,
          ),
          Expanded(
            child: renderSizedBox ? const SizedBox() : stateWidget(),
          ),
        ],
      ),
    );
  }
}

enum TimerState {
  work('work'),
  getReadyForBreak('transition'),
  breakTime('break'),
  readyToStart('done'),
  ;

  const TimerState(this.spacedName);

  final String spacedName;
}

extension TimerStateExtension on TimerState {
  static TimerState fromString(String typeAsString) {
    return TimerState.values.firstWhere(
      (element) => element.toString().split('.').last == typeAsString,
      orElse: () => TimerState.values.first,
    );
  }
}
