import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ProgressIndicatorMolecule extends StatelessWidget {
  const ProgressIndicatorMolecule(
    this.variant, {
    required this.onComplete,
  });

  final ProgressIndicatorVariant variant;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    const Duration getReadyDuration = Duration(seconds: 10);

    switch (variant) {
      case ProgressIndicatorVariant.beforeStudy:
        final List<Tip> tips = tipsList
            .where(
              (element) =>
                  element.timing == TipTiming.inSession &&
                  (element.type == StudyTypeAbstract.instance!.studyType ||
                      element.type == TipType.general),
            )
            .toList();

        return Column(
          children: [
            const TextAtom(
              'ready_study',
              variant: TextVariant.smallTitle,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextAtom('Some tips:'),
                  const SeparatorAtom(),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, item) {
                      final Tip tip = tips[item];

                      return TextAtom(tip.text);
                    },
                    itemCount: tips.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SeparatorAtom(),
                  ),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  ProgressIndicatorAtom(
                    totalDuration: getReadyDuration,
                    callback: onComplete,
                  ),
                ],
              ),
            ),
          ],
        );
      case ProgressIndicatorVariant.beforeBreak:
        final List<Tip> tips = tipsList
            .where(
              (element) =>
                  element.timing == TipTiming.inBreak &&
                  (element.type == StudyTypeAbstract.instance!.studyType ||
                      element.type == TipType.general),
            )
            .toList();

        return Column(
          children: [
            const TextAtom(
              'ready_for_break',
              variant: TextVariant.smallTitle,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextAtom('Some tips:'),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, item) {
                      final Tip tip = tips[item];

                      return TextAtom(tip.text);
                    },
                    itemCount: tips.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SeparatorAtom(),
                  ),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  ProgressIndicatorAtom(
                    totalDuration: getReadyDuration,
                    callback: onComplete,
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }
}

enum ProgressIndicatorVariant { beforeStudy, beforeBreak }
