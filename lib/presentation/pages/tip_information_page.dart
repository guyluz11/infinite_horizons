import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/objects/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/core/snack_bar_service.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TipInformationPage extends StatefulWidget {
  const TipInformationPage({
    required this.tip,
    super.key,
  });
  final Tip tip;

  @override
  State<TipInformationPage> createState() => _TipInformationPageState();
}

class _TipInformationPageState extends State<TipInformationPage> {
  late Map<String, bool> isExpanded;
  @override
  void initState() {
    super.initState();
    isExpanded = <String, bool>{};
    for (final element in widget.tip.resourceLinks) {
      isExpanded[element.title] = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'tip_description',
      topBarType: TopBarType.back,
      expendChild: false,
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
                            TextAtom(widget.tip.type.name),
                          ],
                        ),
                        Row(
                          children: [
                            const TextAtom('timing:'),
                            const SeparatorAtom(
                              variant: SeparatorVariant.relatedElements,
                            ),
                            TextAtom(widget.tip.timing.name),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextAtom('tip:'),
                            const SeparatorAtom(
                              variant: SeparatorVariant.relatedElements,
                            ),
                            Flexible(
                              child: TextAtom(
                                widget.tip.text,
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
                        if (widget.tip.resourceLinks.isEmpty)
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
                              ExpansionPanelList(
                                expansionCallback: (panelIndex, expanded) {
                                  setState(() {
                                    isExpanded.forEach((key, value) {
                                      isExpanded[key] = false;
                                    });
                                    isExpanded[isExpanded.keys
                                        .elementAt(panelIndex)] = expanded;
                                  });
                                },
                                children: widget.tip.resourceLinks
                                    .map<ExpansionPanel>(
                                  (Resource r) {
                                    final Uri? link = r.link;

                                    return ExpansionPanel(
                                      isExpanded: isExpanded[r.title]!,
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
                                          setState(() {
                                            isExpanded[r.title] = false;
                                          });
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
                                              IconButton(
                                                onPressed: () {
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
                                                icon: const Icon(Icons.link),
                                              ),
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
