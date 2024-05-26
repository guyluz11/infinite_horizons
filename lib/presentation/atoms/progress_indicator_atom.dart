import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

// ignore: must_be_immutable
class ProgressIndicatorAtom extends StatefulWidget {
  ProgressIndicatorAtom({
    required this.totalDuration,
    required this.callback,
    this.controller,
    this.isPdfLoader = false,
    this.centerWidget = const SizedBox(),
  });

  final Duration totalDuration;
  final VoidCallback callback;
  AnimationController? controller;
  final bool isPdfLoader;
  final Widget centerWidget;

  @override
  State<ProgressIndicatorAtom> createState() => _ProgressIndicatorAtomState();
}

class _ProgressIndicatorAtomState extends State<ProgressIndicatorAtom>
    with TickerProviderStateMixin {
  @override
  void initState() {
    updateProgress();
    super.initState();
  }

  void updateProgress() {
    widget.controller ??= AnimationController(
      vsync: this,
      duration: widget.totalDuration,
    );
    widget.controller!.addListener(() {
      setState(() {});
    });

    widget.controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.callback();
      }
    });
    if (!widget.isPdfLoader) widget.controller!.forward();
  }

  @override
  void dispose() {
    widget.controller!.dispose();
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
        value: widget.controller!.value,
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
