import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_tracker/progress_tracker.dart';

class ProgressTrackerAtom extends StatelessWidget {
  const ProgressTrackerAtom(this.states, this.currentState);

  final List<String> states;
  final String currentState;

  @override
  Widget build(BuildContext context) {
    final int currentIndex = states.indexOf(currentState);
    final List<Status> statusList = [];
    bool active = true;

    for (final String state in states) {
      final bool isCurrentState = state == currentState;
      statusList.add(
        Status(
          name: isCurrentState
              ? state[0].toUpperCase() + state.substring(1)
              : state,
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
