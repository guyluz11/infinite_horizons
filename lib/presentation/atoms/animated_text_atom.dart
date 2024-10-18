import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:vibration/vibration.dart';

class AnimatedTextAtom extends StatefulWidget {
  const AnimatedTextAtom({
    required this.text,
    required this.onDone,
    required this.variant,
    this.textColorWhite = false,
  });

  final String text;
  final VoidCallback onDone;
  final bool textColorWhite;
  final AnimatedTextVariant variant;

  @override
  _AnimatedTextAtomState createState() => _AnimatedTextAtomState();
}

class _AnimatedTextAtomState extends State<AnimatedTextAtom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;
  bool isOnDone = false;
  bool isFlicking = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _charCount =
        StepTween(begin: 0, end: widget.text.length).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onDoneOnce() {
    if (isOnDone) {
      return;
    }
    isOnDone = true;
    widget.onDone();
  }

  Widget typewriter() {
    String currentText = widget.text.substring(0, _charCount.value);

    if (_charCount.value > 0 && _charCount.value <= widget.text.length) {
      Vibration.vibrate(duration: 1);
    }

    if (_charCount.value == widget.text.length) {
      onDoneOnce();
    } else {
      currentText += '_';
    }

    return TextAtom(
      currentText,
      variant: TextVariant.title,
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget flicker() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 35,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 8.0,
              color: Colors.white,
            ),
          ],
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            FlickerAnimatedText(
              widget.text,
            ),
          ],
          isRepeatingAnimation: false,
          onNext: (i, b) {
            setState(() {
              isFlicking = false;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case AnimatedTextVariant.typewriter:
        return typewriter();
      case AnimatedTextVariant.flicker:
        return flicker();
    }
  }
}

enum AnimatedTextVariant {
  typewriter,
  flicker,
}
