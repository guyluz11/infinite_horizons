import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ProgressIndicatorMolecule extends StatelessWidget {
  const ProgressIndicatorMolecule({
    required this.duration,
    required this.onComplete,
    this.initialValue,
  });

  final Duration duration;
  final VoidCallback onComplete;
  final Duration? initialValue;

  @override
  Widget build(BuildContext context) {
    final List<Tip> tips = tipsList
        .where(
          (element) =>
              element.timing == TipTiming.inBreak &&
              (element.type == StudyTypeAbstract.instance!.tipType ||
                  element.type == TipType.general),
        )
        .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO: Remove after we add break tips for analytical and creative
        if (tips.isNotEmpty)
          Column(
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
            ],
          ),
        ProgressIndicatorAtom(
          totalDuration: duration,
          callback: onComplete,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
