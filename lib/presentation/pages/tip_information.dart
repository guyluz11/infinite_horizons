import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';
import 'package:url_launcher/url_launcher.dart';

class TipInformation extends StatelessWidget {
  const TipInformation(this.tip);

  final Tip tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarMolecule(
            pageName: tip.text,
            leftIcon: Icons.arrow_back,
            leftIconFunction: (c) => Navigator.of(c).pop(),
          ),
          if (tip.resourceLinks.isEmpty) const TextAtom('resource_is_empty'),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, r) {
                final Uri link = tip.resourceLinks[r];

                return ButtonAtom(
                  variant: ButtonVariant.tertiary,
                  onPressed: () => launchUrl(link),
                  text: 'Resource ${r + 1}',
                );
              },
              separatorBuilder: (context, r) => const SeparatorAtom(),
              itemCount: tip.resourceLinks.length,
            ),
          ),
        ],
      ),
    );
  }
}
