import 'package:flutter/material.dart';

class ProgressIndicatorAtom extends StatefulWidget {
  const ProgressIndicatorAtom(this.totalDuration, this.callback);

  /// In Seconds
  final Duration totalDuration;
  final VoidCallback callback;

  @override
  State<ProgressIndicatorAtom> createState() => _ProgressIndicatorAtomState();
}

class _ProgressIndicatorAtomState extends State<ProgressIndicatorAtom>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    updateProgress();
    super.initState();
  }

  void updateProgress() {
    controller = AnimationController(
      vsync: this,
      duration: widget.totalDuration,
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.callback();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
    );
  }
}
