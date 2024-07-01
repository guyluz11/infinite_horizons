import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/study_type_abstract.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/infrastructure/core/logger.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/check_box_tile_molecule.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/all_tips_page.dart';
import 'package:infinite_horizons/presentation/pages/tip_information_page.dart';

class TipsOrganism extends StatefulWidget {
  const TipsOrganism(this.studyType);

  final String studyType;

  @override
  State<TipsOrganism> createState() => _TipsOrganismState();
}

class _TipsOrganismState extends State<TipsOrganism> {
  late ConfettiController confettiController;
  bool? isDnd;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    checkIsDnd();
    getWakeTime();
  }

  Future getWakeTime() async {
    final DateTime? wakeUpTime =
        await HealthController.instance.getWakeUpTime();
    // TODO: Create new tips that are time based, add new category display.
    // Filter the correct tips from there
    // Add tips about the intensity of the light, the direction, or if the user should go to sleep!.
    logger.i('Wake up time $wakeUpTime');
  }

  Future checkIsDnd() async {
    final bool isDndTemp;
    if (Platform.isAndroid) {
      isDndTemp = await DndController.instance.isDnd();
    } else {
      isDndTemp = false;
    }

    setState(() {
      isDnd = isDndTemp;
    });
  }

  void onCheckBox(int id, bool value) =>
      StudyTypeAbstract.instance!.setTipValue(id, value);

  @override
  Widget build(BuildContext context) {
    final List<Tip> beforeStudyTips = StudyTypeAbstract.instance!
        .getTips()
        .where(
          (element) =>
              (element.timing == TipTiming.before &&
                  (element.type == TipType.general ||
                      element.type == StudyTypeAbstract.instance!.tipType)) &&
              // We can toggle dnd only on android
              !(element.id == 'dnd' && Platform.isAndroid),
        )
        .toList();

    final Tip dndTip = StudyTypeAbstract.instance!
        .getTips()
        .firstWhere((element) => element.id == 'dnd');

    return PageEnclosureMolecule(
      scaffold: false,
      title: 'efficient_tips'.tr(args: [widget.studyType.tr()]),
      topBarTranslate: false,
      child: isDnd == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Platform.isAndroid)
                    Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              child: CardAtom(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextAtom(
                                      'Toggle to active',
                                      variant: TextVariant.smallTitle,
                                    ),
                                    const SeparatorAtom(),
                                    ToggleSwitchMolecule(
                                      text: dndTip.text,
                                      offIcon:
                                          Icons.do_not_disturb_off_outlined,
                                      onIcon: Icons.do_not_disturb_on_outlined,
                                      onChange: (value) {
                                        confettiController.play();
                                        DndController.instance.enableDnd();
                                      },
                                      initialValue: isDnd!,
                                      trailing: IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TipInformationPage(tip: dndTip),
                                          ),
                                        ),
                                        icon: const Icon(Icons.arrow_forward),
                                      ),
                                      lockOnToggleOn: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              child: ConfettiAtom(confettiController),
                            ),
                          ],
                        ),
                        const SeparatorAtom(variant: SeparatorVariant.farApart),
                      ],
                    ),
                  CardAtom(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextAtom(
                          'Check list',
                          variant: TextVariant.smallTitle,
                        ),
                        const SeparatorAtom(),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final Tip tip = beforeStudyTips[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: CheckBoxTileMolecule(
                                tip.text,
                                callback: (value) =>
                                    onCheckBox(tip.itemCountNumber, value),
                                initialValue: tip.selected,
                                onIconPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TipInformationPage(tip: tip),
                                  ),
                                ),
                                variant: ListTileSubtitleVariant.strikethrough,
                              ),
                            );
                          },
                          itemCount: beforeStudyTips.length,
                        ),
                      ],
                    ),
                  ),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  ButtonAtom(
                    variant: ButtonVariant.lowEmphasisText,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllTipsPage()),
                    ),
                    text: 'studies_link',
                    icon: Icons.library_books,
                  ),
                ],
              ),
            ),
    );
  }
}
