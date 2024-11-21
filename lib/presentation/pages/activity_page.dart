import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with WidgetsBindingObserver {
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
    TimerStateManager.timerStates = WorkTypeAbstract.instance!.getTimerStates();

    WidgetsBinding.instance.addObserver(this);
    PlayerController.instance.setIsSound(
      PreferencesController.instance.getBool(PreferenceKeys.isSound) ?? true,
    );
    PlayerController.instance.play(SoundType.startSession);
    VibrationController.instance.vibrate(VibrationType.heavy);
    TimerStateManager.iterateOverTimerStates();
    notificationPermissionPopup();
  }

  AppLifecycleState currentAppState = AppLifecycleState.resumed;

  Future notificationPermissionPopup() async {
    final bool notificationPermissionRequested = PreferencesController.instance
            .getBool(PreferenceKeys.notificationPermissionRequested) ??
        false;
    final bool notificationGranted =
        await NotificationsController.instance.isPermissionGranted();
    if (
        // TODO: Remove
        // notificationPermissionRequested ||
        notificationGranted) {
      return;
    }
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) {
      return;
    }
    PreferencesController.instance
        .setBool(PreferenceKeys.notificationPermissionRequested, true);
    requestNotificationPermissionPopup(context);
  }

  Future<bool> onWillPop(bool didPop, dynamic result) async {
    if (_currentTabNum == 0) {
      backToHomePopup(context);
    } else {
      animateToPage(0);
    }

    return false;
  }

  Future<void> animateToPage(int pageNum) async {
    _pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void setAppState(AppLifecycleState val) {
    if (val == AppLifecycleState.paused || val == AppLifecycleState.resumed) {
      currentAppState = val;
    }
  }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState appState) async {
    switch (appState) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        setAppState(appState);
        return;
      case AppLifecycleState.resumed:
        if (currentAppState == AppLifecycleState.resumed) {
          return;
        }

        setAppState(appState);

        NotificationsController.instance.cancelAllNotifications();

        final DateTime preferencePausedTime = PreferencesController.instance
            .getDateTime(PreferenceKeys.pausedTime)!;
        final TimerState preferenceTimerState = TimerStateExtension.fromString(
          PreferencesController.instance.getString(PreferenceKeys.timerState) ??
              '',
        );
        final Duration preferenceRemainingTimerTime = PreferencesController
                .instance
                .getDuration(PreferenceKeys.remainingTimerTime) ??
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
        setAppState(appState);

        final bool isTimerRunning = TimerStateManager.isTimerRunning();

        TimerStateManager.pauseTimer();
        PreferencesController.instance
            .setDateTime(PreferenceKeys.pausedTime, DateTime.now());
        PreferencesController.instance.setString(
          PreferenceKeys.timerState,
          TimerStateManager.state.name,
        );
        PreferencesController.instance.setDuration(
          PreferenceKeys.remainingTimerTime,
          TimerStateManager.remainingTime ?? Duration.zero,
        );

        if (!isTimerRunning) {
          return;
        }

        final upcomingStates = TimerStateManager.upcomingStates(
          TimerStateManager.state,
          TimerStateManager.remainingTime,
        );
        for (final UpcomingState stateWithTime in upcomingStates) {
          if (stateWithTime.state != TimerState.getReadyForBreak &&
              stateWithTime.state != TimerState.readyToStart) {
            String title;
            String body;
            NotificationVariant notificationVariant;
            if (stateWithTime.state == TimerState.work) {
              title = 'break'.tr();
              body = 'work_ended'.tr();
              notificationVariant = NotificationVariant.workEnded;
            } else {
              title = 'new_session'.tr();
              body = 'break_ended'.tr();
              notificationVariant = NotificationVariant.breakEnded;
            }

            await NotificationsController.instance.send(
              date: stateWithTime.endTime,
              title: title,
              body: body,
              variant: notificationVariant,
            );
          }
        }
        return;
    }
  }

  @override
  void dispose() {
    TimerStateManager.pauseTimer();
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void callback(int index) {
    _currentTabNum = index;
    animateToPage(_currentTabNum);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: onWillPop,
      canPop: false,
      child: Scaffold(
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              if (index == 0) {
                FocusScope.of(context).unfocus();
              }
              _currentTabNum = index;
            });
          },
          controller: _pageController,
          children: _tabs(),
        ),
        bottomNavigationBar:
            BottomNavigationBarHomePage(callback, _currentTabNum),
      ),
    );
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
