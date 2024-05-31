import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class TimerOrganism extends StatefulWidget {
  @override
  State<TimerOrganism> createState() => _TimerOrganismState();
}

class _TimerOrganismState extends State<TimerOrganism>
    with AutomaticKeepAliveClientMixin<TimerOrganism> {
  HomeState state = HomeState.study;
  final PreferencesController _prefs = PreferencesController.instance;

  @override
  bool get wantKeepAlive => true;
  bool lockScreen = true;

  @override
  void initState() {
    super.initState();
    lockScreen = _prefs.getBool("isLockScreen") ?? lockScreen;
    WakeLockController.instance.setWakeLock(lockScreen);
    PlayerController.instance.setIsSound(_prefs.getBool("isSound") ?? true);

    if (lockScreen) {
      WakeLockController.instance.setWakeLock(true);
    }
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
      case HomeState.getReadyForBreak:
        nextState = HomeState.breakTime;
      case HomeState.breakTime:
        nextState = HomeState.readyToStart;
      case HomeState.readyToStart:
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
        return TimerMolecule(
          setNextState,
          StudyTypeAbstract.instance!.energy.duration,
        );

      case HomeState.getReadyForBreak:
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
        return ProgressIndicatorMolecule(onComplete: setNextState);
      case HomeState.breakTime:
        return TimerMolecule(
          setNextState,
          GlobalVariables.breakTime(
            StudyTypeAbstract.instance!.energy.duration,
          ),
        );
      case HomeState.readyToStart:
        PlayerController.instance.play('break_ended.wav');

        return ReadyForSessionOrganism(setNextState);
    }
  }

  void topBarSecondary(BuildContext context) {
    final Widget body = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBarMolecule(
          title: "settings",
          topBarType: TopBarType.none,
          margin: false,
        ),
        const SeparatorAtom(),
        CardAtom(
          child: ToggleButtonMolecule(
            text: 'sound',
            offIcon: Icons.music_off_rounded,
            onIcon: Icons.music_note_rounded,
            onChange: (bool value) {
              PlayerController.instance.setIsSound(value);
              _prefs.setBool("isSound", value);
            },
            initialValue: PlayerController.instance.isSound(),
          ),
        ),
        const SeparatorAtom(),
        CardAtom(
          child: ToggleButtonMolecule(
            text: 'screen_lock',
            offIcon: Icons.lock_clock,
            onIcon: Icons.lock_open,
            onChange: (bool value) {
              lockScreen = value;
              _prefs.setBool("isLockScreen", lockScreen);
              WakeLockController.instance.setWakeLock(lockScreen);
            },
            initialValue: lockScreen,
          ),
        ),
        const SeparatorAtom(
          variant: SeparatorVariant.farApart,
        ),
      ],
    );
    openAlertDialog(context, body);
  }

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TopBarMolecule(
          title: title,
          topBarType: TopBarType.none,
          secondaryButtonOnTap: () => topBarSecondary(context),
          margin: false,
        ),
        const SeparatorAtom(variant: SeparatorVariant.farApart),
        Expanded(
          child: stateWidget(),
        ),
      ],
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
