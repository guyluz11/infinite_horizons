import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/all_tips_page.dart';

class TipsOrganism extends StatelessWidget {
  const TipsOrganism(this.onNext, this.studyType);

  final VoidCallback onNext;
  final String studyType;

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

    return MarginedExpandedAtom(
      child: Column(
        children: [
          TopBarMolecule(
            title: 'efficient_tips'.tr(args: [studyType.tr()]),
            topBarType: TopBarType.none,
            margin: false,
            translate: false,
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
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
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          Row(
            children: [
              ButtonAtom(
                variant: ButtonVariant.tertiary,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllTipsPage()),
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
      ),
    );
  }
}
