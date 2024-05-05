import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class TimerAtom extends StatelessWidget {
  const TimerAtom(this.controller, this.timer, this.callback);

  final CountDownController controller;
  final Duration timer;
  final VoidCallback callback;

  void onComplete() {
    // TODO: Play complete sound
    callback();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return CircularCountDownTimer(
      duration: timer.inSeconds,
      controller: controller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.grey[300]!,
      fillColor: Colors.purpleAccent[100]!,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
        fontSize: 33.0,
        color: colorScheme.onBackground,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.MM_SS,
      isReverseAnimation: true,
      isReverse: true,
      onComplete: onComplete,
      isControlButtonShown: true,

    );
  }
}
