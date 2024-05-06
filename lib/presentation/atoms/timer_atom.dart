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
              width: min(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
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
                            alignment: FractionalOffset.center,
                            child: TextAtom(
                              "${time.minutes}:${time.seconds}",
                              style: TextStyle(
                                fontSize: 33.0,
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              translate: false,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
