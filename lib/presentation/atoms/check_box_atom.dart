import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';

class CheckBoxAtom extends StatefulWidget {
  const CheckBoxAtom({
    required this.callback,
    this.initialValue = false,
    this.controlByParent = false,
  });

  final bool initialValue;
  final Function(bool) callback;
  final bool controlByParent;

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
    if (widget.controlByParent) {
      isChecked = widget.initialValue;
    }

    return Checkbox(
      value: isChecked,
      onChanged: onChange,
    );
  }
}
