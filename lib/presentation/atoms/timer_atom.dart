import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/infrastructure/core/logger.dart';

class TimerAtom extends StatelessWidget {
  const TimerAtom(this.controller);

  final CountDownController controller;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 10,
      controller: controller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.grey[300]!,
      fillColor: Colors.purpleAccent[100]!,
      backgroundColor: Colors.purple[500],
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.S,
      isReverseAnimation: true,
      isReverse: true,
      autoStart: false,
      onStart: () {
        logger.i('wow');
        debugPrint('Countdown Started');
      },
      onComplete: () {
        print('wow');
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        print('wow');
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        print('wow');
        if (duration.inSeconds == 0) {
          return "Start";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
