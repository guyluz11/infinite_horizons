import 'package:flutter/widgets.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:vibration/vibration.dart';

class AnimatedTextAtom extends StatefulWidget {
  const AnimatedTextAtom({
    required this.text,
    required this.onDone,
  });

  final String text;
  final VoidCallback onDone;

  @override
  _AnimatedTextAtomState createState() => _AnimatedTextAtomState();
}

class _AnimatedTextAtomState extends State<AnimatedTextAtom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;
  bool isOnDone = false;

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

  @override
  Widget build(BuildContext context) {
    String currentText = widget.text.substring(0, _charCount.value);

    // Trigger vibration for each letter
    if (_charCount.value > 0 && _charCount.value <= widget.text.length) {
      Vibration.vibrate(duration: 1); // Vibrate for 50ms
    }

    if (_charCount.value == widget.text.length) {
      onDoneOnce();
    } else {
      currentText += '_';
    }

    return TextAtom(
      currentText,
      variant: TextVariant.title,
    );
  }
}
