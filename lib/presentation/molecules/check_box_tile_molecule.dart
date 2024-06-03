import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/atoms/strikethrough_tile_atom.dart';

class CheckBoxTileMolecule extends StatefulWidget {
  const CheckBoxTileMolecule(
    this.text, {
    required this.callback,
    this.initialValue = false,
    this.onIconPressed,
  });

  final String text;
  final bool initialValue;
  final Function(bool) callback;
  final VoidCallback? onIconPressed;

  @override
  State<CheckBoxTileMolecule> createState() => _CheckBoxTileMolecule();
}

class _CheckBoxTileMolecule extends State<CheckBoxTileMolecule> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void onChange() {
    setState(() {
      isChecked = !isChecked;
    });
    VibrationController.instance.vibrate(VibrationType.light);

    widget.callback(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return StrikethroughTileAtom(
      widget.text,
      trailing: (widget.onIconPressed != null)
          ? IconButton(
              onPressed: widget.onIconPressed,
              icon: const Icon(Icons.arrow_forward),
            )
          : const SizedBox(),
      leading: CheckBoxAtom(
        callback: (value) => onChange(),
        initialValue: isChecked,
        controlByParent: true,
      ),
      onTap: onChange,
      isCrossed: isChecked,
    );
  }
}
