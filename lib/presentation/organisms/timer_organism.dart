import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class TimerOrganism extends StatelessWidget {
  const TimerOrganism(this.variant, {required this.onComplete});

  final TimerVariant variant;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
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
                : GlobalVariables.breakTime(
                    StudyTypeAbstract.instance!.energy.duration,
                  ),
          ),
        ),
        const SeparatorAtom(),
      ],
    );
  }
}

enum TimerVariant { study, breakTime }
