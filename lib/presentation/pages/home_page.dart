import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/notifications_controller.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentTabNum = 0;

  final GlobalKey<TimerOrganismState> timerKey =
      GlobalKey<TimerOrganismState>();

  List<Widget> _tabs() => [
        TimerOrganism(key: timerKey),
        TextAreaOrganism(),
      ];

  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PlayerController.instance
        .setIsSound(PreferencesController.instance.getBool("isSound") ?? true);
    PlayerController.instance.play('start_session.wav');
    VibrationController.instance.vibrate(VibrationType.heavy);
    TimerStateManager.iterateOverTimerStates();
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState appState) async {
    switch (appState) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        return;
      case AppLifecycleState.resumed:
        NotificationsController.instance.cancelAllNotifications();

        final DateTime preferencePausedTime =
            PreferencesController.instance.getDateTime('pausedTime')!;
        final TimerState preferenceTimerState = TimerStateExtension.fromString(
          PreferencesController.instance.getString('timerState') ?? '',
        );
        final Duration preferenceRemainingTimerTime =
            PreferencesController.instance.getDuration('remainingTimerTime') ??
                Duration.zero;

        setCurrentStateAndRemainingTime(
          preferencePausedTime,
          preferenceTimerState,
          preferenceRemainingTimerTime,
        );
        TimerStateManager.callback?.call();
        TimerStateManager.iterateOverTimerStates(
          remainingTime: TimerStateManager.remainingTime,
        );
        return;
      case AppLifecycleState.paused:
        PreferencesController.instance
            .setDateTime('pausedTime', DateTime.now());
        PreferencesController.instance
            .setString('timerState', TimerStateManager.state.name);
        PreferencesController.instance.setDuration(
          'remainingTimerTime',
          TimerStateManager.remainingTime ?? Duration.zero,
        );

        if (!TimerStateManager.isTimerRunning()) {
          return;
        }

        TimerStateManager.pauseTimer();
        final upcomingStates = TimerStateManager.upcomingStates(
          TimerStateManager.state,
          TimerStateManager.remainingTime,
        );
        for (final UpcomingState stateWithTime in upcomingStates) {
          if (stateWithTime.state != TimerState.getReadyForBreak &&
              stateWithTime.state != TimerState.readyToStart) {
            await NotificationsController.instance.send(
              date: stateWithTime.endTime,
              title: 'State: ${stateWithTime.state}',
            );
          }
        }
        return;
    }
  }

  UpcomingState findLastUpcomingStateBeforeNow(
    List<UpcomingState> upcomingStates,
  ) {
    final DateTime currentTime = DateTime.now();
    UpcomingState? lastStateBeforeNow;

    for (final UpcomingState state in upcomingStates) {
      if (state.endTime.isBefore(currentTime)) {
        lastStateBeforeNow = state;
      } else {
        break;
      }
    }

    return lastStateBeforeNow ?? upcomingStates.first;
  }

  @override
  void dispose() {
    TimerStateManager.pauseTimer();
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void callback(int index) {
    setState(() {
      _currentTabNum = index;
      _pageController.animateToPage(
        _currentTabNum,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentTabNum = index;
          });
        },
        controller: _pageController,
        children: _tabs(),
      ),
      bottomNavigationBar:
          BottomNavigationBarHomePage(callback, _currentTabNum),
    );
  }

  Duration getStateDuration(TimerState state) {
    // TODO: Fix app not taking into account session number
    return StudyTypeAbstract.instance!.getTimerStates().sessions.map((session) {
      if (state == TimerState.study) {
        return session.study;
      } else if (state == TimerState.breakTime) {
        return session.breakDuration;
      }
      return session.getReadyForBreak;
    }).first;
  }

  /// Set the current state and the remaining time by calculating how much time passed
  void setCurrentStateAndRemainingTime(
    DateTime pausedTime,
    TimerState previousTimerState,
    Duration previousRemainingTimerTime,
  ) {
    final List<UpcomingState> upcomingStates = TimerStateManager.upcomingStates(
      previousTimerState,
      previousRemainingTimerTime,
      calculateFromDate: pausedTime,
    );
    final DateTime timeNow = DateTime.now();

    UpcomingState upcomingState = upcomingStates.first;

    for (final UpcomingState tempUpcomingState in upcomingStates) {
      if (tempUpcomingState.startTime().isBefore(timeNow)) {
        upcomingState = tempUpcomingState;
      } else {
        break;
      }
    }

    Duration remainingDuration = Duration.zero;
    if (upcomingStates.last.state != upcomingState.state) {
      remainingDuration = upcomingState.endTime.difference(timeNow);
    }
    TimerStateManager.state = upcomingState.state;
    TimerStateManager.remainingTime = remainingDuration;
  }
}
