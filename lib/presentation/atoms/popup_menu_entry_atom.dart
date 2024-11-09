import 'package:flutter/material.dart';

class PopupMenuEntryAtom<T extends Enum> extends PopupMenuEntry<T> {
  const PopupMenuEntryAtom({
    required this.value,
    required this.child,
    required this.onTap,
  });

  final T value;
  final Widget child;
  final VoidCallback onTap;

  @override
  double get height => 50.0;

  @override
  bool represents(T? value) {
    return value != null && value == this.value;
  }

  @override
  State createState() => _CustomPopupMenuEntryState<T>();
}

class _CustomPopupMenuEntryState<T extends Enum>
    extends State<PopupMenuEntryAtom<T>> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.child,
      onTap: widget.onTap,
    );
  }
}
