import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ProgressIndicatorAtom extends StatefulWidget {
  const ProgressIndicatorAtom({
    required this.totalDuration,
    required this.callback,
    this.inputController,
    this.isPdfLoader = false,
    this.centerWidget,
  });
  final Duration totalDuration;
  final VoidCallback callback;
  final AnimationController? inputController;
  final bool isPdfLoader;
  final Widget? centerWidget;

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
    controller = widget.inputController ??
        AnimationController(
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
    if (!widget.isPdfLoader) {
      controller.forward();
    }
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
        borderRadius: GlobalVariables.defaultRadius,
        borderWidth: GlobalVariables.defaultBorderWidth,
        center: widget.centerWidget,
      ),
    );
  }
}
