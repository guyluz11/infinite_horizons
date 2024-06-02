import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

class TipResourcePage extends StatelessWidget {
  const TipResourcePage({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.endsWith(".pdf")) {
      return PageEnclosureMolecule(
        title: "resource",
        margin: false,
        topBarType: TopBarType.back,
        expendChild: false,
        child: PdfViewerMolecule(
          url: url,
        ),
      );
    } else if (url.contains("youtube") || url.contains("youtu.be")) {
      return YoutubePlayerPage(
        url: url,
      );
    }
    return PageEnclosureMolecule(
      title: "resource",
      margin: false,
      topBarType: TopBarType.back,
      expendChild: false,
      child: WebViewMolecule(
        url: url,
      ),
    );
  }
}
