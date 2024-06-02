import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class ToggleSwitchAtom extends StatefulWidget {
  const ToggleSwitchAtom({
    required this.offIcon,
    required this.onIcon,
    required this.onChange,
    required this.initialValue,
    this.controlByParent = false,
    this.disable = false,
  });

  final IconData offIcon;
  final IconData onIcon;
  final Function(bool value) onChange;
  final bool initialValue;
  final bool controlByParent;
  final bool disable;

  @override
  State<ToggleSwitchAtom> createState() => _ToggleSwitchAtomState();
}

class _ToggleSwitchAtomState extends State<ToggleSwitchAtom> {
  @override
  void initState() {
    super.initState();
    toggle = widget.initialValue;
  }

  late bool toggle;

  void onChange(bool value) {
    setState(() => toggle = value);
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    if (widget.controlByParent) {
      toggle = widget.initialValue;
    }

    return AnimatedToggleSwitch<bool>.rolling(
      style: ToggleStyle(
        backgroundColor: toggle
            ? (widget.disable
                ? colorScheme.onSurface.withOpacity(0.12)
                : colorScheme.primary)
            : (widget.disable
                ? colorScheme.surfaceContainerHighest.withOpacity(0.12)
                : colorScheme.surfaceContainerHighest),
        borderColor: widget.disable
            ? colorScheme.onSurface
            : (toggle ? colorScheme.primary : colorScheme.outline),
        indicatorColor: toggle
            ? (widget.disable
                ? colorScheme.surface.withOpacity(1)
                : colorScheme.onPrimary)
            : (widget.disable
                ? colorScheme.onSurface.withOpacity(0.38)
                : colorScheme.outline),
      ),
      current: toggle,
      values: const [false, true],
      onChanged: widget.disable ? null : onChange,
      iconList: [
        Icon(
          widget.offIcon,
          color: widget.disable
              ? colorScheme.surfaceContainerHighest.withOpacity(0.38)
              : colorScheme.surfaceContainerHighest,
        ),
        Icon(
          widget.onIcon,
          color: widget.disable
              ? colorScheme.onSurface.withOpacity(0.38)
              : colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
