import 'dart:math';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/text_atom.dart';

class TimerAtom extends StatelessWidget {
  const TimerAtom(this.controller, this.timer, this.callback);

  final CustomTimerController controller;
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: CustomTimer(
        controller: controller,
        builder: (state, time) {
          return SizedBox(
            width: min(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      if (value == CustomTimerState.counting) {
                        controller.pause();
                      } else {
                        controller.start();
                      }
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CircularProgressIndicator(
                            backgroundColor: colorScheme.primaryContainer,
                            color: value == CustomTimerState.counting
                                ? colorScheme.primary
                                : colorScheme.outline,
                            value: time.duration.inMilliseconds /
                                timer.inMilliseconds,
                            strokeWidth: 22,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Align(
                          alignment: value != CustomTimerState.counting
                              ? FractionalOffset.topCenter
                              : FractionalOffset.center,
                          child: Container(
                            padding: value != CustomTimerState.counting
                                ? const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 20,
                                  )
                                : null,
                            child: TextAtom(
                              "${time.minutes}:${time.seconds}",
                              variant: TextVariant.title,
                              textAlign: TextAlign.left,
                              translate: false,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 38,
                              horizontal: 38,
                            ),
                            child: (value != CustomTimerState.counting)
                                ? const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 50.0,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
