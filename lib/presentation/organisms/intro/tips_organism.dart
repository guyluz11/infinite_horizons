import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/domain/objects/work_type_abstract.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/check_box_tile_molecule.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/all_tips_page.dart';
import 'package:infinite_horizons/presentation/pages/tip_information_page.dart';
import 'package:universal_io/io.dart';

class TipsOrganism extends StatefulWidget {
  const TipsOrganism(this.workType);

  final String workType;

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

  Duration? timeFromWake;
  bool didPulledWakeTime = false;

  Future getWakeTime() async {
    if (!await HealthController.instance.isPermissionsSleepInBedGranted()) {
      setState(() {
        didPulledWakeTime = true;
      });
      return;
    }
    timeFromWake =
        await HealthController.instance.getEstimatedDurationFromWake();

    setState(() {
      didPulledWakeTime = true;
    });
  }

  Future checkIsDnd() async {
    final bool isDndTemp = await DndController.instance.isDnd();

    setState(() {
      isDnd = isDndTemp;
    });
  }

  void onCheckBox(int id, bool value) =>
      WorkTypeAbstract.instance!.setTipValue(id, value);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final List<Tip> beforeWorkTips = WorkTypeAbstract.instance!.getTips().where(
      (element) {
        if (!element.isCheckbox) {
          return false;
        }
        if (element.timing != TipTiming.before ||
            !(element.type == TipType.general ||
                element.type == WorkTypeAbstract.instance!.tipType)) {
          return false;
        }

        return element.isTipRecommendedNow(
          timeFromWake: timeFromWake,
          now: now,
        );
      },
    ).toList();

    final Tip dndTip = WorkTypeAbstract.instance!
        .getTips()
        .firstWhere((element) => element.id == 'dnd');

    return PageEnclosureMolecule(
      scaffold: false,
      title: 'efficient_tips'.tr(args: [widget.workType.tr()]),
      subTitle: 'Select each element when complete',
      topBarTranslate: false,
      child: isDnd == null || !didPulledWakeTime
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
                                      text: dndTip.actionText,
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final Tip tip = beforeWorkTips[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: CheckBoxTileMolecule(
                                tip.actionText,
                                textIcon: tip.icon,
                                subtitle: tip.reason,
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
                          itemCount: beforeWorkTips.length,
                        ),
                      ],
                    ),
                  ),
                  const SeparatorAtom(),
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
