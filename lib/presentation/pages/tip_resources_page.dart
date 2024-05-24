import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
      return Scaffold(
        body: Column(
          children: [
            TopBarMolecule(
              topBarType: TopBarType.back,
              title: "Resource",
              onTap: () => Navigator.pop(context),
            ),
            const SeparatorAtom(variant: SeparatorVariant.closeWidgets),
            Expanded(
              child: PdfViewerMolecule(
                url: url,
              ),
            ),
          ],
        ),
      );
    } else if (url.contains("youtube") || url.contains("youtu.be")) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: double.infinity,
              color: Colors.transparent.withOpacity(0.5),
            ),
          ),
          YoutubePlayerMolecule(
            url: url,
            hideThumbnail: true,
          ),
        ],
      );
    }
    return Scaffold(
      body: Column(
        children: [
          TopBarMolecule(
            topBarType: TopBarType.back,
            title: "Resource",
            onTap: () => Navigator.pop(context),
          ),
          const SeparatorAtom(variant: SeparatorVariant.closeWidgets),
          Expanded(child: WebViewMolecule(url: url)),
        ],
      ),
    );
  }
}
