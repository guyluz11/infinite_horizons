import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
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
  // TODO: save toggled state for next time

  @override
  bool get wantKeepAlive => true;
  bool lockScreen = true;

  @override
  void initState() {
    super.initState();
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
        PlayerController.instance.play('start_session.wav');
        VibrationController.instance.vibrate(VibrationType.heavy);
        return timerWithTitle(variant: TimerVariant.study);
      case HomeState.getReadyForBreak:
        PlayerController.instance.play('session_completed.wav');
        VibrationController.instance.vibrate(VibrationType.medium);
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeBreak,
          onComplete: onTimerComplete,
        );
      case HomeState.breakTime:
        return timerWithTitle(variant: TimerVariant.breakTime);

      case HomeState.getReadyForStudy:
        return ProgressIndicatorMolecule(
          ProgressIndicatorVariant.beforeStudy,
          onComplete: onTimerComplete,
        );
    }
  }

  void secondaryButtonOnTap(BuildContext context) {
    final Widget body = SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopBarMolecule(
            title: "settings",
            topBarType: TopBarType.none,
          ),
          SeparatorAtom(
            variant: SeparatorVariant.generalSpacing,
          ),
          ToggleButtonMolecule(
            text: 'Sound',
            offIcon: Icons.music_off_rounded,
            onIcon: Icons.music_note_rounded,
            onChange: (bool value) =>
                PlayerController.instance.setSilentState(!value),
            initialValue: !PlayerController.instance.isSilent(),
          ),
          SeparatorAtom(),
          ToggleButtonMolecule(
            text: 'Screen Lock',
            offIcon: Icons.lock_clock,
            onIcon: Icons.lock_open,
            onChange: (bool value) {
              lockScreen = value;
              WakeLockController.instance.setWakeLock(lockScreen);
            },
            initialValue: lockScreen,
          ),
          SeparatorAtom(
            variant: SeparatorVariant.farApart,
          ),
        ],
      ),
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
