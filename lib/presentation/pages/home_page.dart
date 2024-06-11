import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/background_service_controller.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
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
        // TODO: Check for ios
        if (Platform.isAndroid) {
          BackgroundServiceController.instance.stopService();
          await Future.delayed(const Duration(milliseconds: 200));
        }
        await PreferencesController.instance.reload();
        final TimerState state = TimerStateExtension.fromString(
          PreferencesController.instance.getString('timerState') ?? '',
        );
        TimerStateManager.state = state;

        final Duration remainingTime =
            PreferencesController.instance.getDuration('remainingTimerTime') ??
                Duration.zero;
        TimerStateManager.iterateOverTimerStates(remainingTime: remainingTime);
        timerKey.currentState?.setCurrentState();
        return;
      case AppLifecycleState.paused:
        if (TimerStateManager.state == TimerState.readyToStart) {
          return;
        }

        TimerStateManager.pauseTimer();
        PreferencesController.instance.setDuration(
          'remainingTimerTime',
          TimerStateManager.getRemainingTime() ?? Duration.zero,
        );

        PreferencesController.instance
            .setString('timerState', TimerStateManager.state.name);
        // TODO: Check how it react
        if (!Platform.isAndroid) {
          return;
        }
        await BackgroundServiceController.instance.startService();
        BackgroundServiceController.instance.startIterateTimerStates();
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
