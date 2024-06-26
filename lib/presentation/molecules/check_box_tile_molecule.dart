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
  late bool isCrossed;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
    isCrossed = isChecked;
  }

  Future onChange() async {
    if (!isChecked) {
      PlayerController.instance.play(SoundType.checkBoxChecked);
      setState(() {
        isChecked = !isChecked;
      });
      await Future.delayed(const Duration(milliseconds: 800));

      PlayerController.instance.play(SoundType.strikethrough);
      setState(() {
        isCrossed = isChecked;
      });
    } else {
      setState(() {
        isChecked = !isChecked;
        isCrossed = isChecked;
      });
    }

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
        isSound: false,
      ),
      onTap: onChange,
      variant: ListTileSubtitleVariant.strikethrough,
      isCrossed: isCrossed,
    );
  }
}
