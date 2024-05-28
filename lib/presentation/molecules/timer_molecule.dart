import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class TimerMolecule extends StatefulWidget {
  const TimerMolecule(this.onComplete, this.duration);

  final Duration duration;
  final VoidCallback onComplete;

  @override
  State<TimerMolecule> createState() => _TimerMoleculeState();
}

class _TimerMoleculeState extends State<TimerMolecule>
    with SingleTickerProviderStateMixin {
  late final CustomTimerController controller = CustomTimerController(
    vsync: this,
    begin: widget.duration,
    end: Duration.zero,
  );

  @override
  void initState() {
    super.initState();
    controller.start();
    controller.addListener(() {
      if (controller.state.value == CustomTimerState.finished) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TimerAtom(
        controller,
        widget.duration,
        widget.onComplete,
      ),
    );
  }
}
