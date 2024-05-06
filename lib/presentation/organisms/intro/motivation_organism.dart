import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class MotivationOrganism extends StatelessWidget {
  const MotivationOrganism(this.callback);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    String text;
    switch (StudyTypeAbstract.instance!.energy) {
      case EnergyType.undefined:
        text = '';
      case EnergyType.veryLow:
        text =
            "Happy to see you starting.\nStarting is not always easy task and you made it.\nLet's do this 🌟";
      case EnergyType.low:
        text = 'We will start slowly together and increase our Energy 😁';
      case EnergyType.medium:
        text = 'Let’s do this 🙌 🙌 🙌 🙌';
      case EnergyType.high:
        text = 'Ready?, set, Gooo';
      case EnergyType.veryHigh:
        text =
            "You are full of energy today aren’t you 🤩\nLet's put it to good use";
      case EnergyType.max:
        text = "So much energy 🔋⚡🔋⚡🔋⚡🔋\nLet's begin";
    }

    return Expanded(
      child: MarginedExpandedAtom(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TopBarMolecule(
              title: 'lets_start',
              topBarType: TopBarType.none,
              margin: false,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextAtom(text),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  ButtonAtom(
                    variant: ButtonVariant.primary,
                    onPressed: callback,
                    text: 'start',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
