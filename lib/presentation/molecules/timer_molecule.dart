import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class TimerMolecule extends StatefulWidget {
  const TimerMolecule({required this.duration, required this.initialValue});

  final Duration duration;
  final Duration? initialValue;

  @override
  State<TimerMolecule> createState() => _TimerMoleculeState();
}

class _TimerMoleculeState extends State<TimerMolecule>
    with SingleTickerProviderStateMixin {
  late CustomTimerController controller;

  @override
  void initState() {
    super.initState();
    setController();
  }

  void setController() {
    controller = CustomTimerController(
      vsync: this,
      begin: widget.initialValue ?? widget.duration,
      end: Duration.zero,
    );
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: TimerAtom(
              controller,
              widget.duration,
            ),
          ),
        ),
        const SeparatorAtom(),
      ],
    );
  }
}
