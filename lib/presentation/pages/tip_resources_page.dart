import 'package:flutter/material.dart';
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
      return TipResourceMolecule(
        innerWidget: PdfViewerMolecule(
          url: url,
        ),
        title: "resource",
      );
    } else if (url.contains("youtube") || url.contains("youtu.be")) {
      return TipResourceMolecule(
        innerWidget: YoutubePlayerMolecule(
          url: url,
        ),
        title: "resource",
      );
    }
    return TipResourceMolecule(
      innerWidget: WebViewMolecule(
        url: url,
      ),
      title: "resource",
    );
  }
}
