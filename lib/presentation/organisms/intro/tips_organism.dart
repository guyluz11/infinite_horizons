import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/pages/all_tips.dart';

class TipsOrganism extends StatelessWidget {
  void onCheckBox(int id, bool value) =>
      StudyTypeAbstract.instance!.setTipValue(id, value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final Tip tip = StudyTypeAbstract.instance!.getTips()[index];

            return CheckBoxAtom(
              tip.text,
              callback: (value) => onCheckBox(tip.id, value),
              initialValue: tip.selected,
            );
          },
          itemCount: StudyTypeAbstract.instance!.getTips().length,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonAtom(
              variant: ButtonVariant.tertiary,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AllTips()),
              ),
              text: 'studies_link',
            ),
          ],
        ),
      ],
    );
  }
}
