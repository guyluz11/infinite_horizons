import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/domain/objects/work_type_analytical.dart';
import 'package:infinite_horizons/domain/objects/work_type_creatively.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class WorkTypeSelectionMolecule extends StatefulWidget {
  const WorkTypeSelectionMolecule(this.onSelected);

  final VoidCallback onSelected;

  @override
  State<WorkTypeSelectionMolecule> createState() =>
      _WorkTypeSelectionMoleculeState();
}

class _WorkTypeSelectionMoleculeState extends State<WorkTypeSelectionMolecule> {
  late TipType selectedType;
  bool isTextFinished = false;
  late Tip analyticalTip;
  late Tip creativeTip;
  late List<Tip> recommendedTips;
  Duration? timeFromWake;
  bool didPulledWakeTime = false;
  late List<String> recommendedTypeText;

  @override
  void initState() {
    super.initState();
    selectedType = WorkTypeAbstract.instance?.tipType ?? TipType.undefined;
    initializeTips();
  }

  void onChanged(TipType? type) {
    setState(() {
      selectedType = type ?? TipType.undefined;
    });
    WorkTypeAbstract.instance = selectedType == TipType.analytical
        ? WorkTypeAnalytical()
        : WorkTypeCreatively();

    PreferencesController.instance
        .setString(PreferenceKeys.tipType, selectedType.name);

    widget.onSelected();
  }

  Future initializeTips() async {
    analyticalTip = tipsList.firstWhereOrNull(
      (element) => element.id == 'recommended in the morning',
    )!;
    creativeTip = tipsList.firstWhereOrNull(
      (element) => element.id == 'recommended in the evening',
    )!;

    if (await HealthController.instance.isPermissionsSleepInBedGranted()) {
      timeFromWake =
          await HealthController.instance.getEstimatedDurationFromWake();
    }
    recommendedTypeText = getRecommendedTypeText();
    setState(() {
      didPulledWakeTime = true;
    });
  }

  List<String> getRecommendedTypeText() {
    final DateTime now = DateTime.now();
    recommendedTips = [];

    if (creativeTip.isTipRecommendedNow(timeFromWake: timeFromWake, now: now)) {
      recommendedTips.add(creativeTip);
    }

    if (analyticalTip.isTipRecommendedNow(
      timeFromWake: timeFromWake,
      now: now,
    )) {
      recommendedTips.add(analyticalTip);
    }

    if (recommendedTips.isEmpty) {
      recommendedTips.add(creativeTip);
      recommendedTips.add(analyticalTip);
    }

    final String recommendedTipText =
        recommendedTips.map((tip) => '${tip.actionText} Activity').join(', ');
    return [
      if (recommendedTips.length == 1)
        'We recommend you to work on:'
      else
        'Pick one:',
      recommendedTipText,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      scaffold: false,
      title: 'work_type',
      subTitle: 'Choose a work type',
      child: didPulledWakeTime
          ? Column(
              children: [
                CardAtom(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: isTextFinished
                            ? TextAtom(
                                recommendedTypeText.join('\n'),
                                variant: TextVariant.title,
                              )
                            : AnimatedTextAtom(
                                recommendedTypeText,
                                onFinished: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {
                                      isTextFinished = true;
                                    });
                                  });
                                },
                              ),
                      ),
                      if (isTextFinished)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SeparatorAtom(
                              variant: SeparatorVariant.closeWidgets,
                            ),
                            TextAtom('* ${recommendedTips.first.reason}'),
                            if (recommendedTips.length > 1)
                              TextAtom('* ${recommendedTips[1].reason}'),
                          ],
                        ),
                    ],
                  ),
                ),
                if (isTextFinished) ...[
                  const SeparatorAtom(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonAtom(
                        text: creativeTip.actionText,
                        icon: creativeTip.icon,
                        variant: ButtonVariant.mediumHighEmphasisFilledTonal,
                        onPressed: () {
                          VibrationController.instance
                              .vibrate(VibrationType.light);
                          onChanged(TipType.creative);
                        },
                      ),
                      ButtonAtom(
                        text: analyticalTip.actionText,
                        icon: analyticalTip.icon,
                        variant: ButtonVariant.mediumHighEmphasisFilledTonal,
                        onPressed: () {
                          VibrationController.instance
                              .vibrate(VibrationType.light);
                          onChanged(TipType.analytical);
                        },
                      ),
                    ],
                  ),
                ],
              ],
            )
          : const CircularProgressIndicator(),
    );
  }
}
