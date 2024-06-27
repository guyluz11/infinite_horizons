import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
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

  Widget label(TextTheme textTheme, {Color? color}) => TextAtom(
        text ?? '',
        translate: translate,
        maxLines: 1,
        style: textTheme.bodyLarge!.copyWith(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    switch (variant) {
      case ButtonVariant.highEmphasisFilled:
        if (icon == null) {
          return buttonConstraints(
            child: FilledButton(
              onPressed: disabled ? null : onPressed,
              style: disabled
                  ? null
                  : FilledButton.styleFrom().copyWith(
                      alignment: Alignment.center,
                      backgroundColor: WidgetStateProperty.all(
                        colorScheme.secondaryContainer,
                      ),
                    ),
              child: label(textTheme, color: colorScheme.onPrimaryContainer),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.icon(
            onPressed: disabled ? null : onPressed,
            style: disabled
                ? null
                : FilledButton.styleFrom().copyWith(
                    alignment: Alignment.center,
                    backgroundColor:
                        WidgetStateProperty.all(colorScheme.secondaryContainer),
                  ),
            icon: Icon(icon, color: colorScheme.onPrimaryContainer),
            label: label(textTheme, color: colorScheme.onPrimaryContainer),
          ),
        );
      case ButtonVariant.mediumEmphasisOutlined:
        if (icon == null) {
          return buttonConstraints(
            child: OutlinedButton(
              onPressed: disabled ? null : onPressed,
              child: label(textTheme, color: colorScheme.primary),
            ),
          );
        }
        return buttonConstraints(
          child: OutlinedButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: Icon(icon, color: colorScheme.primary),
            label: label(textTheme, color: colorScheme.primary),
          ),
        );
      case ButtonVariant.lowEmphasisText:
        if (icon == null) {
          return buttonConstraints(
            child: TextButton(
              onPressed: disabled ? null : onPressed,
              child: label(textTheme, color: colorScheme.primary),
            ),
          );
        }
        return buttonConstraints(
          child: TextButton.icon(
            onPressed: disabled ? null : onPressed,
            icon: Icon(icon, color: colorScheme.primary),
            label: label(textTheme, color: colorScheme.primary),
          ),
        );
      case ButtonVariant.lowEmphasisIcon:
        return IconButton(
          onPressed: onPressed,
          color: colorScheme.primary,
          icon: Icon(icon),
        );
    }
  }
}

/// See "Choosing buttons" section https://m3.material.io/components/all-buttons
enum ButtonVariant {
  highEmphasisFilled,
  mediumEmphasisOutlined,
  lowEmphasisText,
  lowEmphasisIcon,
}
