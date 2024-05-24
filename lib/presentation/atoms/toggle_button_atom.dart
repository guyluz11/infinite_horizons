import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class ToggleButtonAtom extends StatefulWidget {
  const ToggleButtonAtom({
    required this.offIcon,
    required this.onIcon,
    required this.onChange,
    required this.initialValue,
  });

  @override
  State<ToggleButtonAtom> createState() => _ToggleButtonAtomState();

  final IconData offIcon;
  final IconData onIcon;
  final Function(bool value) onChange;
  final bool initialValue;
}

class _ToggleButtonAtomState extends State<ToggleButtonAtom> {
  @override
  void initState() {
    super.initState();
    toggle = widget.initialValue;
  }

  late bool toggle;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    return AnimatedToggleSwitch<bool>.rolling(
      style: ToggleStyle(
        backgroundColor: colorScheme.outline,
        borderColor: colorScheme.outline,
        indicatorColor: colorScheme.primary,
      ),
      current: toggle,
      values: const [false, true],
      onChanged: (value) {
        setState(() => toggle = value);
        widget.onChange(value);
      },
      iconList: [
        Icon(widget.offIcon),
        Icon(widget.onIcon),
      ],
    );
  }
}
