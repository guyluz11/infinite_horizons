import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TimerOrganism extends StatefulWidget {
  @override
  State<TimerOrganism> createState() => _TimerOrganismState();
}

class _TimerOrganismState extends State<TimerOrganism>
    with AutomaticKeepAliveClientMixin<TimerOrganism> {
  HomeState state = HomeState.getReadyForStudy;
  final PreferencesController _prefs = PreferencesController.instance;

  @override
  bool get wantKeepAlive => true;
  bool lockScreen = true;
  bool firstStudyCompleted = false;

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

  void onTimerComplete() {
    HomeState nextState;
    switch (state) {
      case HomeState.study:
        nextState = HomeState.getReadyForBreak;
      case HomeState.getReadyForBreak:
        nextState = HomeState.breakTime;
      case HomeState.breakTime:
        nextState = HomeState.getReadyForStudy;
      case HomeState.getReadyForStudy:
        nextState = HomeState.study;
    }

    setState(() {
      state = nextState;
    });
  }

  Widget timerWithTitle({required TimerVariant variant}) {
    return Column(
      children: [
        TextAtom(
          variant == TimerVariant.study ? 'study_timer' : 'take_break',
          variant: TextVariant.smallTitle,
        ),
        Expanded(
          child: TimerMolecule(
            onTimerComplete,
            variant == TimerVariant.study
                ? StudyTypeAbstract.instance!.energy.duration
                : GlobalVariables.breakTime(
                    StudyTypeAbstract.instance!.energy.duration,
                  ),
          ),
        ),
        const SeparatorAtom(),
      ],
    );
  }

  Widget stateWidget() {
    switch (state) {
      case HomeState.study:
        if (!firstStudyCompleted) {
          PlayerController.instance.play('start_session.wav');
        }
        VibrationController.instance.vibrate(VibrationType.heavy);
        return timerWithTitle(variant: TimerVariant.study);
      case HomeState.getReadyForBreak:
        firstStudyCompleted = true;
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeBreak,
          onComplete: onTimerComplete,
        );
      case HomeState.breakTime:
        return timerWithTitle(variant: TimerVariant.breakTime);
      case HomeState.getReadyForStudy:
        if (firstStudyCompleted) {
          PlayerController.instance.play('start_session.wav');
        }
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeStudy,
          onComplete: onTimerComplete,
        );
    }
  }

  void secondaryButtonOnTap(BuildContext context) {
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
        ToggleButtonMolecule(
          text: 'sound',
          offIcon: Icons.music_off_rounded,
          onIcon: Icons.music_note_rounded,
          onChange: (bool value) {
            PlayerController.instance.setIsSound(value);
            _prefs.setBool("isSound", value);
          },
          initialValue: PlayerController.instance.isSound(),
        ),
        const SeparatorAtom(),
        ToggleButtonMolecule(
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TopBarMolecule(
          title: 'study_efficiency',
          topBarType: TopBarType.none,
          secondaryButtonOnTap: () => secondaryButtonOnTap(context),
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
  getReadyForStudy,
  ;
}

enum TimerVariant { study, breakTime }
