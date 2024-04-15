import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class HomePage extends StatelessWidget {
  final CountDownController controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextAtom('Maximize Study Efficiency'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TimerAtom(
                    controller,
                    StudyTypeAbstract.instance!.energy.minutes,
                  ),
                ),
                const SeparatorAtom(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonAtom(
                      variant: ButtonVariant.primary,
                      onPressed: controller.start,
                      text: 'Start',
                    ),
                    ButtonAtom(
                      variant: ButtonVariant.secondary,
                      onPressed: controller.start,
                      text: 'Pause',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
