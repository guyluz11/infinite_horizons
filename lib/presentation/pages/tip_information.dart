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
            pageName: 'tip_description',
            leftIcon: Icons.arrow_back,
            leftIconFunction: (c) => Navigator.of(c).pop(),
          ),
          if (tip.resourceLinks.isEmpty) const TextAtom('resource_is_empty'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const TextAtom('type:'),
                      const SeparatorAtom(
                        variant: SeparatorVariant.relatedElements,
                      ),
                      TextAtom(tip.type.name),
                    ],
                  ),
                  Row(
                    children: [
                      const TextAtom('timing:'),
                      const SeparatorAtom(
                        variant: SeparatorVariant.relatedElements,
                      ),
                      TextAtom(tip.timing.name),
                    ],
                  ),
                  Row(
                    children: [
                      const TextAtom('tip:'),
                      const SeparatorAtom(
                        variant: SeparatorVariant.relatedElements,
                      ),
                      TextAtom(tip.text),
                    ],
                  ),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  ExpansionPanelList.radio(
                    children: tip.resourceLinks.map<ExpansionPanelRadio>(
                      (Resource r) {
                        final Uri? link = r.link;

                        return ExpansionPanelRadio(
                          value: r.title,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return TextAtom(r.title);
                          },
                          body: Row(
                            children: [
                              Expanded(
                                child: TextAtom(r.resourceExplanation),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (link == null) {
                                    return;
                                  }
                                  launchUrl(link);
                                },
                                icon: const Icon(Icons.link),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
