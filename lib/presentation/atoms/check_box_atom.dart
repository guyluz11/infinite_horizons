import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class CheckBoxAtom extends StatefulWidget {
  const CheckBoxAtom(
    this.text, {
    required this.callback,
    this.initialValue = false,
    this.trailing,
  });

  final String text;
  final bool initialValue;
  final Function(bool) callback;
  final Widget? trailing;

  @override
  State<CheckBoxAtom> createState() => _CheckBoxAtomState();
}

class _CheckBoxAtomState extends State<CheckBoxAtom> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void onChange(bool? value) {
    setState(() {
      isChecked = value!;
    });
    VibrationController.instance.vibrate(VibrationType.light);

    widget.callback(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: TextAtom(widget.text),
        controlAffinity: ListTileControlAffinity.leading,
        value: isChecked,
        onChanged: onChange,
      ),
      trailing: widget.trailing,
    );
  }
}
