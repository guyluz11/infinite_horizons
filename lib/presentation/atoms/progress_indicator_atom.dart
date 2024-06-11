import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ProgressIndicatorAtom extends StatefulWidget {
  const ProgressIndicatorAtom({
    required this.totalDuration,
    this.inputController,
    this.isPdfLoader = false,
    this.centerWidget,
    this.initialValue,
  });

  final Duration totalDuration;
  final AnimationController? inputController;
  final bool isPdfLoader;
  final Widget? centerWidget;
  final Duration? initialValue;

  @override
  State<ProgressIndicatorAtom> createState() => _ProgressIndicatorAtomState();
}

class _ProgressIndicatorAtomState extends State<ProgressIndicatorAtom>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    initiateController();
    super.initState();
  }

  void initiateController() {
    final double initialValueRatio =
        (widget.initialValue?.inMilliseconds ?? 0) /
            widget.totalDuration.inMilliseconds;

    controller = widget.inputController ??
        AnimationController(
          vsync: this,
          duration: widget.totalDuration,
          value: initialValueRatio,
        );
    controller.addListener(() {
      setState(() {});
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
        backgroundColor: colorScheme.secondaryContainer,
        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        borderColor: colorScheme.outline,
        borderRadius: GlobalVariables.defaultRadius,
        borderWidth: GlobalVariables.defaultBorderWidth,
        center: widget.centerWidget,
      ),
    );
  }
}
