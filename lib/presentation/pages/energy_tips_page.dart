import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/timer_states.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class EnergyTipsPage extends StatelessWidget {
  const EnergyTipsPage(this.type);

  final EnergyType type;

  @override
  Widget build(BuildContext context) {
    final List<Tip> tips =
        tipsList.where((element) => type.tipsId!.contains(element.id)).toList();

    return PageEnclosureMolecule(
      title: type.name,
      topBarType: TopBarType.back,
      expendChild: false,
      child: Column(
        children: [
          CardAtom(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextAtom(
                  'Tips',
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
                      trailing: const FaIcon(FontAwesomeIcons.circleQuestion),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TipInformationPage(tip: tip),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => const SeparatorAtom(),
                  itemCount: tips.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
