import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ProgressIndicatorMolecule extends StatelessWidget {
  const ProgressIndicatorMolecule({
    required this.duration,
    this.initialValue,
  });

  final Duration duration;
  final Duration? initialValue;

  @override
  Widget build(BuildContext context) {
    final List<Tip> tips = tipsList
        .where(
          (element) =>
              element.timing == TipTiming.inBreak &&
              (element.type == WorkTypeAbstract.instance!.tipType ||
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextAtom('Some tips:'),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, item) {
                  final Tip tip = tips[item];

                  return TextAtom(tip.actionText);
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
          initialValue: initialValue,
        ),
      ],
    );
  }
}
