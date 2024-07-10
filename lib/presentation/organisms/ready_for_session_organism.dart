import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/domain/objects/study_type_abstract.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ReadyForSessionOrganism extends StatefulWidget {
  const ReadyForSessionOrganism(
    this.onComplete, {
    this.response,
  });

  final VoidCallback onComplete;
  final String? response;

  @override
  State<ReadyForSessionOrganism> createState() =>
      _ReadyForSessionOrganismState();
}

class _ReadyForSessionOrganismState extends State<ReadyForSessionOrganism> {
  late ConfettiController confetti;
  bool nextPressed = false;
  bool confettiGotPlayed = false;

  void onPressed() {
    if (nextPressed) {
      return;
    }
    VibrationController.instance.vibrate(VibrationType.light);
    setState(() {
      nextPressed = true;
    });
    confetti.play();
  }

  @override
  void initState() {
    super.initState();
    confetti = ConfettiController(duration: const Duration(seconds: 2));
    confetti.addListener(() {
      if (!nextPressed ||
          confetti.state == ConfettiControllerState.playing ||
          confettiGotPlayed) {
        return;
      }
      confettiGotPlayed = true;
      widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Tip> tips = tipsList
        .where(
          (element) =>
              element.timing == TipTiming.inSession &&
              (element.type == StudyTypeAbstract.instance!.tipType ||
                  element.type == TipType.general),
        )
        .toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.response != null)
                  CardAtom(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextAtom(widget.response!),
                    ),
                  ),
                const SeparatorAtom(),
                const SeparatorAtom(),
                CardAtom(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextAtom(
                        'in_session_tips',
                        variant: TextVariant.smallTitle,
                      ),
                      const SeparatorAtom(),
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
                    ],
                  ),
                ),
                const SeparatorAtom(variant: SeparatorVariant.farApart),
              ],
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              Align(
                child: ConfettiAtom(confetti),
              ),
              Align(
                child: ButtonAtom(
                  variant: ButtonVariant.highEmphasisFilled,
                  disabled: nextPressed,
                  onPressed: onPressed,
                  text: 'ready',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
