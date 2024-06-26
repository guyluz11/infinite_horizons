import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';

class AnimatedLineThroughAtom extends StatelessWidget {
  const AnimatedLineThroughAtom({
    required this.child,
    required this.isCrossed,
    this.isSound = true,
    super.key,
  });

  final Widget child;
  final bool isCrossed;
  final bool isSound;

  @override
  Widget build(BuildContext context) {
    if (isSound && isCrossed) {
      PlayerController.instance.play(SoundType.strikethrough);
    }

    return AnimatedLineThrough(
      duration: const Duration(milliseconds: 200),
      strokeWidth: 2,
      isCrossed: isCrossed,
      child: child,
    );
  }
}
