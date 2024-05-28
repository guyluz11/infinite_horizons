import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ButtonAtom extends StatelessWidget {
  const ButtonAtom({
    required this.variant,
    required this.onPressed,
    super.key,
    this.text,
    this.icon,
    this.disabled = false,
    this.disableActionType = false,
    this.translate = true,
  });

  final ButtonVariant variant;
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;

  double get width => 150;

  double get _height => 60;
  final bool disabled;
  final bool translate;
  final bool disableActionType;

  void onPressVibrate() {
    VibrationController.instance.vibrate(VibrationType.light);
    onPressed();
  }

  Widget buttonConstraints({required Widget child}) => Container(
        constraints: BoxConstraints(
          minWidth: width,
        ),
        height: _height,
        child: child,
      );

  Widget label(TextTheme textTheme) => TextAtom(
        text ?? '',
        translate: translate,
        maxLines: 1,
        style: textTheme.bodyLarge,
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    switch (variant) {
      case ButtonVariant.primary:
        if (icon == null) {
          return buttonConstraints(
            child: FilledButton(
              onPressed: onPressVibrate,
              style: FilledButton.styleFrom().copyWith(
                alignment: Alignment.center,
                backgroundColor: disabled
                    ? WidgetStateProperty.all(colorScheme.outline)
                    : null,
              ),
              child: label(textTheme),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.icon(
            onPressed: onPressVibrate,
            style: FilledButton.styleFrom().copyWith(
              alignment: Alignment.center,
              backgroundColor: disabled
                  ? WidgetStateProperty.all(colorScheme.outline)
                  : null,
            ),
            icon: Icon(icon),
            label: label(textTheme),
          ),
        );
      case ButtonVariant.secondary:
        if (icon == null) {
          return buttonConstraints(
            child: FilledButton.tonal(
              onPressed: onPressed,
              style: FilledButton.styleFrom().copyWith(
                alignment: Alignment.center,
                backgroundColor: disabled
                    ? WidgetStateProperty.all(colorScheme.outline)
                    : null,
              ),
              child: label(textTheme),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.icon(
            onPressed: onPressed,
            style: FilledButton.styleFrom().copyWith(
              alignment: Alignment.center,
              backgroundColor: disabled
                  ? WidgetStateProperty.all(colorScheme.outline)
                  : null,
            ),
            icon: Icon(icon),
            label: label(textTheme),
          ),
        );
      case ButtonVariant.tertiary:
        if (icon == null) {
          return buttonConstraints(
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom().copyWith(
                alignment: Alignment.center,
                backgroundColor: disabled
                    ? WidgetStateProperty.all(colorScheme.outline)
                    : WidgetStateProperty.all(colorScheme.tertiaryContainer),
              ),
              child: label(textTheme),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.icon(
            onPressed: onPressed,
            style: FilledButton.styleFrom().copyWith(
              alignment: Alignment.center,
              backgroundColor: disabled
                  ? WidgetStateProperty.all(colorScheme.outline)
                  : WidgetStateProperty.all(colorScheme.tertiaryContainer),
            ),
            icon: Icon(icon),
            label: label(textTheme),
          ),
        );
      case ButtonVariant.iconButton:
        return IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        );
    }
  }
}

enum ButtonVariant {
  primary,
  secondary,
  tertiary,

  /// No borders
  iconButton,
  // action,
  // actionToggled,
  // back,
}
