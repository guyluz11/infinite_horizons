import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/molecules/web_view_molecule.dart';

class TipResourcePage extends StatelessWidget {
  const TipResourcePage({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.endsWith(".pdf")) {
      return TipResourceWidget(
        innerWidget: PdfViewerMolecule(
          url: url,
        ),
      );
    } else if (url.contains("youtube") || url.contains("youtu.be")) {
      return TipResourceWidget(
        innerWidget: YoutubePlayerMolecule(
          url: url,
        ),
      );
    }
    return TipResourceWidget(
        innerWidget: WebViewMolecule(
      url: url,
    ),);
  }
}

class TipResourceWidget extends StatelessWidget {
  const TipResourceWidget({
    required this.innerWidget, super.key,
  });

  final Widget innerWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBarMolecule(
            topBarType: TopBarType.back,
            title: "resource",
          ),
          const SeparatorAtom(variant: SeparatorVariant.closeWidgets),
          Expanded(child: innerWidget),
        ],
      ),
    );
  }
}
