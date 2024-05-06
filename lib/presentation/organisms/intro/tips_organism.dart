import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/pages/all_tips.dart';

class TipsOrganism extends StatelessWidget {
  const TipsOrganism(this.onNext);

  final VoidCallback onNext;

  void onCheckBox(int id, bool value) =>
      StudyTypeAbstract.instance!.setTipValue(id, value);

  @override
  Widget build(BuildContext context) {
    final List<Tip> beforeStudyTips = StudyTypeAbstract.instance!
        .getTips()
        .where(
          (element) =>
              element.timing == TipTiming.before &&
                  element.type == TipType.general ||
              element.type == StudyTypeAbstract.instance!.studyType,
        )
        .toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final Tip tip = beforeStudyTips[index];

            return CheckBoxAtom(
              tip.text,
              callback: (value) => onCheckBox(tip.id, value),
              initialValue: tip.selected,
            );
          },
          itemCount: beforeStudyTips.length,
        ),
        const SeparatorAtom(),
        Row(
          children: [
            ButtonAtom(
              variant: ButtonVariant.tertiary,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllTips()),
              ),
              text: 'studies_link',
            ),
            const Expanded(
              child: SizedBox(),
            ),
            ButtonAtom(
              variant: ButtonVariant.primary,
              onPressed: onNext,
              text: 'next',
            ),
          ],
        ),
      ],
    );
  }
}
