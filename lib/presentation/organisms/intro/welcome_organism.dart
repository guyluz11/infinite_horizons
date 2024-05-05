import 'package:flutter/cupertino.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class WelcomeOrganism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextAtom(
          "Sometimes we study new material but can't remember as much as we would like to.\nSometimes we work but our focus isn't as strong as we know it could be.\nUsing this app your study and work session efficiency can increase dramatically by following methods that got approved by science.",
        ),
        const SeparatorAtom(),
        Image.asset('assets/logo.png'),
      ],
    );
  }
}
