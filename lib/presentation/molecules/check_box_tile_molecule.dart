import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class CheckBoxTileMolecule extends StatefulWidget {
  const CheckBoxTileMolecule(
    this.text, {
    required this.callback,
    this.initialValue = false,
    this.onIconPressed,
    this.variant = ListTileSubtitleVariant.text,
  });

  final String text;
  final bool initialValue;
  final Function(bool) callback;
  final VoidCallback? onIconPressed;
  final ListTileSubtitleVariant variant;

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
    return ListTileAtom(
      widget.text,
      trailing: (widget.onIconPressed != null)
          ? IconButton(
              onPressed: widget.onIconPressed,
              icon: const FaIcon(FontAwesomeIcons.circleQuestion),
            )
          : const SizedBox(),
      leading: CheckBoxAtom(
        callback: (value) => onChange(),
        initialValue: isChecked,
        controlByParent: true,
      ),
      onTap: onChange,
      variant: ListTileSubtitleVariant.strikethrough,
      isCrossed: isChecked,
    );
  }
}
