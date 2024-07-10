import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class AnimatedTextAtom extends StatefulWidget {
  const AnimatedTextAtom(this.animatedTexts, {this.onFinished});

  final List<String> animatedTexts;
  final VoidCallback? onFinished;

  @override
  State<AnimatedTextAtom> createState() => _AnimatedTextAtomState();
}

class _AnimatedTextAtomState extends State<AnimatedTextAtom> {
  int textRendered = 0;

  Widget animatedWidgets() {
    final List<Widget> widgets = [];

    for (int i = 0; i < widget.animatedTexts.length; i++) {
      final String text = widget.animatedTexts[i];
      if (i < textRendered) {
        widgets.add(
          TextAtom(
            text,
            variant: TextVariant.title,
          ),
        );
        if (i == widget.animatedTexts.length - 1) {
          widget.onFinished?.call();
        }
        continue;
      }
      final ThemeData themeData = Theme.of(context);

      final TextTheme textTheme = themeData.textTheme;

      widgets.add(
        AnimatedTextKit(
          key: GlobalKey(),
          displayFullTextOnTap: true,
          isRepeatingAnimation: false,
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: textTheme.headlineMedium,
              speed: const Duration(milliseconds: 40),
            ),
          ],
          onFinished: () {
            setState(() {
              textRendered++;
            });
          },
        ),
      );
      break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return animatedWidgets();
  }
}
