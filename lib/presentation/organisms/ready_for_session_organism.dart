import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class ReadyForSessionOrganism extends StatefulWidget {
  const ReadyForSessionOrganism(
    this.onComplete, {
    this.topText,
  });

  final VoidCallback onComplete;
  final String? topText;

  @override
  State<ReadyForSessionOrganism> createState() =>
      _ReadyForSessionOrganismState();
}

class _ReadyForSessionOrganismState extends State<ReadyForSessionOrganism> {
  final Duration confettiDuration = const Duration(seconds: 2);

  late ConfettiController controllerCenter;
  bool nextPressed = false;
  bool isConfettiStart = false;

  @override
  void initState() {
    super.initState();
    controllerCenter = ConfettiController(duration: confettiDuration);
    controllerCenter.addListener(() {
      if (!nextPressed ||
          controllerCenter.state == ConfettiControllerState.playing) {
        return;
      }
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tip> tips = tipsList
        .where(
          (element) =>
              element.timing == TipTiming.inSession &&
              (element.type == StudyTypeAbstract.instance!.studyType ||
                  element.type == TipType.general),
        )
        .toList();

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.topText != null)
                Column(
                  children: [
                    TextAtom(widget.topText!),
                    const SeparatorAtom(),
                    const SeparatorAtom(),
                  ],
                ),
              const TextAtom(
                'In session tips:',
                variant: TextVariant.smallTitle,
              ),
              const SeparatorAtom(),
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
        ),
        Expanded(
          child: Center(
            child: Stack(
              children: [
                Align(
                  child: ConfettiAtom(controllerCenter),
                ),
                Align(
                  child: ButtonAtom(
                    variant: ButtonVariant.highEmphasisFilled,
                    disabled: nextPressed,
                    onPressed: () {
                      if (nextPressed) {
                        return;
                      }
                      setState(() {
                        nextPressed = true;
                      });
                      controllerCenter.play();
                    },
                    text: 'ready',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
