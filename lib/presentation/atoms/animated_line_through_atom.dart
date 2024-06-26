import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/widgets.dart';

class AnimatedLineThroughAtom extends StatelessWidget {
  const AnimatedLineThroughAtom({
    required this.child,
    required this.isCrossed,
    super.key,
  });

  final Widget child;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    return AnimatedLineThrough(
      duration: const Duration(milliseconds: 300),
      strokeWidth: 2,
      isCrossed: isCrossed,
      child: child,
    );
  }
}
