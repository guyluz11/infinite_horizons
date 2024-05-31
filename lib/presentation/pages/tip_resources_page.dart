import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/youtube_player_page.dart';

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
      return YoutubePlayerPage(
        title: 'resource',
        url: url,
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
