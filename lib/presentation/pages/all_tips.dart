import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:infinite_horizons/presentation/pages/tip_information.dart';

class AllTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarMolecule(
            pageName: 'all_tips',
            leftIcon: Icons.arrow_back,
            leftIconFunction: (c) => Navigator.of(c).pop(),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, n) {
              final Tip tip = tipsList[n];

              return UnconstrainedBox(
                child: ButtonAtom(
                  variant: ButtonVariant.tertiary,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TipInformation(tip),
                    ),
                  ),
                  text: tip.text,
                ),
              );
            },
            separatorBuilder: (context, i) => const SeparatorAtom(),
            itemCount: tipsList.length,
          ),
        ],
      ),
    );
  }
}

// ListView.separated(
//   shrinkWrap: true,
//   physics: const NeverScrollableScrollPhysics(),
//   scrollDirection: Axis.horizontal,
//   itemBuilder: (context, r) {
//     final Uri resource = tip.resourceLinks[r];
//
//     return ButtonAtom(
//       variant: ButtonVariant.tertiary,
//       onPressed: () => launchUrl(resource),
//       // TODO: Add to translation
//       text: 'Link $r',
//     );
//   },
//   separatorBuilder: (context, r) => const SeparatorAtom(),
//   itemCount: tip.resourceLinks.length,
// ),
