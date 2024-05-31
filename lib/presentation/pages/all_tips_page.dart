import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/tip_information_page.dart';

class AllTipsPage extends StatelessWidget {
  Widget tipList(TipType type) {
    final List<Tip> tips =
        tipsList.where((element) => element.type == type).toList();

    return Column(
      children: [
        TextAtom(
          type.name,
          variant: TextVariant.smallTitle,
        ),
        const SeparatorAtom(),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, n) {
            final Tip tip = tips[n];

            return ListTileAtom(
              tip.text,
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TipInformationPage(tip),
                ),
              ),
            );
          },
          separatorBuilder: (context, i) => const SeparatorAtom(),
          itemCount: tips.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MarginedExpandedAtom(
        child: Column(
          children: [
            const TopBarMolecule(
              title: 'all_tips',
              topBarType: TopBarType.back,
              margin: false,
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardAtom(
                      child: tipList(TipType.general),
                    ),
                    const SeparatorAtom(variant: SeparatorVariant.farApart),
                    CardAtom(
                      child: tipList(TipType.analytical),
                    ),
                    const SeparatorAtom(variant: SeparatorVariant.farApart),
                    CardAtom(
                      child: tipList(TipType.creative),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
