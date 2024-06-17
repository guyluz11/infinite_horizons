import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/notifications_controller.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/infrastructure/core/logger.dart';
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
        //
        // await PreferencesController.instance.reload();
        // final TimerState state = TimerStateExtension.fromString(
        //   PreferencesController.instance.getString('timerState') ?? '',
        // );
        // TimerStateManager.state = state;
        //
        // final Duration remainingTime =
        //     PreferencesController.instance.getDuration('remainingTimerTime') ??
        //         Duration.zero;
        // TimerStateManager.iterateOverTimerStates(remainingTime: remainingTime);
        // timerKey.currentState?.setCurrentState();
        return;
      case AppLifecycleState.paused:
        if (!TimerStateManager.isTimerRunning()) {
          return;
        }
        TimerStateManager.pauseTimer();
        PreferencesController.instance.setDuration(
          'remainingTimerTime',
          TimerStateManager.getRemainingTime() ?? Duration.zero,
        );
        PreferencesController.instance
            .setString('timerState', TimerStateManager.state.name);

        createNotificationsForStates();
        return;
    }
  }

  Future createNotificationsForStates() async {
    Duration durationForState =
        TimerStateManager.getRemainingTime() ?? Duration.zero;

    DateTime time = DateTime.now();
    TimerState tempState = TimerStateManager.state;

    while (durationForState != Duration.zero) {
      time = time.add(durationForState);
      if (tempState != TimerState.getReadyForBreak) {
        await NotificationsController.instance
            .send(date: time, title: 'State: $tempState', body: 'asd');
        logger.i('Time for notification $tempState is $time');
      }
      tempState = TimerStateManager.getNextState(tempState);
      durationForState = TimerStateManager.getTimerDuration(tempState);
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
}
