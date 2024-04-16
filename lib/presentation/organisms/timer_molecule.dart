import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class TimerMolecule extends StatelessWidget {
  TimerMolecule(this.onComplete, this.duration);

  final Duration duration;
  final VoidCallback onComplete;

  final CountDownController controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TimerAtom(
              controller,
              duration,
              onComplete,
            ),
          ),
          const SeparatorAtom(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonAtom(
                variant: ButtonVariant.primary,
                onPressed: controller.resume,
                text: 'Continue',
              ),
              ButtonAtom(
                variant: ButtonVariant.secondary,
                onPressed: controller.pause,
                text: 'Pause',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
