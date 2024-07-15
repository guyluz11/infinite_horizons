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
      statusList.add(
        Status(
          name: state,
          icon: state == currentState ? FontAwesomeIcons.caretDown : null,
          active: active,
        ),
      );
      if (state == currentState) {
        active = false;
      }
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return ProgressTracker(
      currentIndex: currentIndex,
      statusList: statusList,
      activeColor: colorScheme.onSurface,
      inActiveColor: colorScheme.outlineVariant,
    );
  }
}
