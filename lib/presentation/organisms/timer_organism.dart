import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TimerOrganism extends StatelessWidget {
  const TimerOrganism(this.variant, {required this.onComplete});

  final TimerVariant variant;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    const int breakTimeRatio = 5;

    return Column(
      children: [
        TextAtom(
          variant == TimerVariant.study ? 'study_timer' : 'take_break',
          variant: TextVariant.smallTitle,
        ),
        Expanded(
          child: TimerMolecule(
            onComplete,
            variant == TimerVariant.study
                ? StudyTypeAbstract.instance!.energy.duration
                : Duration(
                    milliseconds: StudyTypeAbstract
                            .instance!.energy.duration.inMilliseconds ~/
                        breakTimeRatio,
                  ),
          ),
        ),
        const SeparatorAtom(),
      ],
    );
  }
}

enum TimerVariant { study, breakTime }
