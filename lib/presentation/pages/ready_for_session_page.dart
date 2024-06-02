import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class ReadyForSessionPage extends StatelessWidget {
  const ReadyForSessionPage(this.callback);

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

    return PageEnclosureMolecule(
      scaffold: false,
      title: 'start_session',
      child: ReadyForSessionOrganism(
        callback,
        response: text,
      ),
    );
  }
}
