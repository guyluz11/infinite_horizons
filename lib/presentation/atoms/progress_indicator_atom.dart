import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ProgressIndicatorAtom extends StatefulWidget {
  const ProgressIndicatorAtom(this.totalDuration, this.callback);

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
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: LiquidLinearProgressIndicator(
        value: controller.value,
        backgroundColor: colorScheme.outline,
        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        borderColor: colorScheme.outline,
        borderRadius: 10,
        borderWidth: 2,
        center: TextAtom(
          '${(controller.value * 100).toInt()}%',
          translate: false,
        ),
      ),
    );
  }
}
