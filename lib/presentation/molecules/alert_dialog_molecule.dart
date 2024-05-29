import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';

void openAlertDialog(BuildContext context, Widget body) {
  showDialog(
    context: context,
    builder: (_) => UpdateAppDialogMolecule(body),
  );
}

class UpdateAppDialogMolecule extends StatelessWidget {
  const UpdateAppDialogMolecule(this.body);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                ButtonAtom(
                  variant: ButtonVariant.highEmphasisFilled,
                  onPressed: () => Navigator.pop(context),
                  text: 'close',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
