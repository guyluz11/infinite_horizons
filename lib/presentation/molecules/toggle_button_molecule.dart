import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ToggleButtonMolecule extends StatelessWidget {
  const ToggleButtonMolecule({
    required this.text,
    required this.offIcon,
    required this.onIcon,
    required this.onChange,
    required this.initialValue,
  });

  final String text;

  final IconData offIcon;
  final IconData onIcon;
  final Function(bool value) onChange;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextAtom(text),
        const SeparatorAtom(),
        ToggleButtonAtom(
          offIcon: offIcon,
          onIcon: onIcon,
          onChange: onChange,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
