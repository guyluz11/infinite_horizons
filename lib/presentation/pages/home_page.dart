import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/domain/objects/work_type_analytical.dart';
import 'package:infinite_horizons/domain/objects/work_type_creatively.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/intro_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Tip analyticalTip;
  late Tip creativeTip;
  late List<Tip> recommendedTips;
  Duration? timeFromWake;
  bool didPulledWakeTime = false;
  String? recommendedTypeText;

  @override
  void initState() {
    super.initState();
    initializeTips();
  }

  void onSelectedType(TipType type) {
    WorkTypeAbstract.instance = type == TipType.analytical
        ? WorkTypeAnalytical()
        : WorkTypeCreatively();

    PreferencesController.instance.setString(PreferenceKeys.tipType, type.name);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IntroPage(type)));
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

  String? getRecommendedTypeText() {
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

    if (recommendedTips.isEmpty || recommendedTips.length >= 2) {
      return null;
    }

    final String recommendedTipText =
        recommendedTips.map((tip) => '${tip.actionText} Activity').join(', ');

    return recommendedTipText;
  }

  Widget activityTypeCard({
    required String titleText,
    required String subTitle,
    required VoidCallback onClick,
  }) {
    return CardAtom(
      // TODO: Change the image
      image: Image.asset('assets/logo.png'),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAtom(
              titleText,
              variant: TextVariant.titleLarge,
            ),
            TextAtom(
              subTitle,
            ),
            const SeparatorAtom(),
            ButtonAtom(
              text: 'Start',
              variant: ButtonVariant.mediumEmphasisOutlined,
              onPressed: () {
                VibrationController.instance.vibrate(VibrationType.light);
                onClick();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'home_page',
      subTitle: 'Choose an activity type to start',
      expendChild: false,
      child: didPulledWakeTime
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recommendedTypeText != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextAtom(
                        'We recommend you:${recommendedTypeText!}',
                        variant: TextVariant.smallTitle,
                      ),
                    ),
                    const SeparatorAtom(),
                  ],
                  // TODO: Add question mark to explain why using recommendedTips.first.
                  activityTypeCard(
                    titleText: analyticalTip.actionText,
                    subTitle: 'Structured processes'
                        '\nExamples: Engineering, Analyzing',
                    onClick: () => onSelectedType(TipType.analytical),
                  ),
                  const SeparatorAtom(),
                  activityTypeCard(
                    titleText: creativeTip.actionText,
                    subTitle: 'Abstract thinking'
                        '\nExamples: painting, writing fiction',
                    onClick: () => onSelectedType(TipType.creative),
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
