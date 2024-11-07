import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

void openAlertDialog(BuildContext context, Widget body,
    {VoidCallback? onConfirm}) {
  showDialog(
    context: context,
    builder: (_) => DialogMolecule(body, onConfirm: onConfirm),
  );
}

class DialogMolecule extends StatelessWidget {
  const DialogMolecule(this.body, {this.onConfirm});

  final Widget body;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(bottom: AppThemeData.generalSpacing),
      insetPadding: const EdgeInsets.all(AppThemeData.generalSpacing),
      content: Container(
        width: double.infinity,
        constraints: GlobalVariables.maxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SeparatorAtom(),
            body,
            const SeparatorAtom(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonAtom(
                      variant: ButtonVariant.highEmphasisFilled,
                      onPressed: () => Navigator.pop(context),
                      text: 'close',
                    ),
                    if (onConfirm != null) ...[
                      const SeparatorAtom(),
                      ButtonAtom(
                        variant: ButtonVariant.mediumEmphasisOutlined,
                        onPressed: onConfirm!,
                        text: 'confirm',
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
