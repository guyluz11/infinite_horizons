import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ToggleSwitchMolecule extends StatefulWidget {
  const ToggleSwitchMolecule({
    required this.text,
    required this.offIcon,
    required this.onIcon,
    required this.onChange,
    required this.initialValue,
    this.trailing,
    this.lockOnToggleOn = false,
    this.confettiController,
  });

  final String text;

  final IconData offIcon;
  final IconData onIcon;
  final Function(bool value) onChange;
  final bool initialValue;
  final Widget? trailing;
  final bool lockOnToggleOn;
  final ConfettiController? confettiController;

  @override
  State<ToggleSwitchMolecule> createState() => _ToggleSwitchMoleculeState();
}

class _ToggleSwitchMoleculeState extends State<ToggleSwitchMolecule> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  void onChange() {
    widget.confettiController?.play();
    setState(() {
      isToggled = !isToggled;
    });
    widget.onChange(isToggled);
  }

  Widget switchWidget() => ToggleSwitchAtom(
        offIcon: widget.offIcon,
        onIcon: widget.onIcon,
        onChange: (value) => onChange(),
        initialValue: isToggled,
        controlByParent: true,
        disable: widget.lockOnToggleOn && isToggled,
      );

  @override
  Widget build(BuildContext context) {
    return ListTileAtom(
      onTap: onChange,
      widget.text,
      trailing: widget.trailing ?? switchWidget(),
      leading: widget.trailing != null ? switchWidget() : const SizedBox(),
      enable: !(widget.lockOnToggleOn && isToggled),
    );
  }
}
