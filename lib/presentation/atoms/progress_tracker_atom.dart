import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:progress_tracker/progress_tracker.dart';

class ProgressTrackerAtom extends StatelessWidget {
  const ProgressTrackerAtom(this.states, this.currentState, this.isLastSession);

  final List<UpcomingState> states;
  final TimerState currentState;
  final bool isLastSession;

  String durationAsString(Duration d) {
    if (d == Duration.zero) {
      return '';
    }
    if (d > const Duration(minutes: 59)) {
      return '${d.inHours}h';
    }
    if (d > const Duration(seconds: 59)) {
      return '${d.inMinutes}m';
    }
    if (d > const Duration(milliseconds: 999)) {
      return '${d.inSeconds}s';
    }
    return d.toString();
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = states
        .map((value) => value.state.name)
        .toList()
        .indexOf(currentState.name);
    final List<Status> statusList = [];
    bool active = true;

    for (final UpcomingState upcomingState in states) {
      final bool isCurrentState = upcomingState.state == currentState;
      final String stateName;
      if (!isLastSession && upcomingState.state == TimerState.readyToStart) {
        stateName = 'next session';
      } else {
        stateName = upcomingState.state.spacedName;
      }
      final String statusNames = isCurrentState
          ? stateName[0].toUpperCase() + stateName.substring(1)
          : stateName;

      statusList.add(
        Status(
          name: '$statusNames\n${durationAsString(upcomingState.duration)}',
          icon: isCurrentState ? FontAwesomeIcons.caretDown : null,
          active: active,
        ),
      );
      if (isCurrentState) {
        active = false;
      }
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return ProgressTracker(
      currentIndex: currentIndex,
      statusList: statusList,
      activeColor: colorScheme.primary,
      inActiveColor: colorScheme.secondaryContainer,
    );
  }
}
