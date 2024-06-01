import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/core/snack_bar_service.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TipInformationPage extends StatelessWidget {
  const TipInformationPage({
    required this.tip,
    super.key,
  });
  final Tip tip;

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'tip_description',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CardAtom(
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
                            Flexible(
                              child: TextAtom(
                                tip.text,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SeparatorAtom(variant: SeparatorVariant.farApart),
                  CardAtom(
                    child: Column(
                      children: [
                        if (tip.resourceLinks.isEmpty)
                          const TextAtom('resource_is_empty')
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextAtom(
                                'resources',
                                variant: TextVariant.smallTitle,
                              ),
                              const SeparatorAtom(),
                              ExpansionPanelList.radio(
                                children:
                                    tip.resourceLinks.map<ExpansionPanelRadio>(
                                  (Resource r) {
                                    final Uri? link = r.link;

                                    return ExpansionPanelRadio(
                                      value: r.title,
                                      canTapOnHeader: true,
                                      headerBuilder: (
                                        BuildContext context,
                                        bool isExpanded,
                                      ) {
                                        return Padding(
                                          padding:
                                              GlobalVariables.defaultPadding,
                                          child: TextAtom(r.title),
                                        );
                                      },
                                      body: InkWell(
                                        onTap: () {
                                          if (link == null) {
                                            SnackBarService().show(
                                              context,
                                              "no_link",
                                            );
                                            return;
                                          }
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TipResourcePage(
                                                url: link.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding:
                                              GlobalVariables.defaultPadding,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextAtom(
                                                  r.resourceExplanation,
                                                ),
                                              ),
                                              const Icon(Icons.link),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
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
