import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TipResourcePage extends StatelessWidget {
  const TipResourcePage({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.contains("pdf")) {
      return Scaffold(
        body: Column(
          children: [
            TopBarMolecule(
              topBarType: TopBarType.back,
              title: "Resource",
              onTap: () => Navigator.pop(context),
            ),
            const SeparatorAtom(variant: SeparatorVariant.closeWidgets),
            Expanded(child: PdfViewerMolecule(url, true, true, Colors.blue)),
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
          YouTubePlayerMolecule(url, true, true, Colors.red, Colors.red,
              Colors.red, const EdgeInsets.all(8.0))
        ],
      );
    } else {
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
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(url)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget PdfViewerMolecule(String url, bool autoSpacing, bool pageFling,
      Color progressIndicatorColor) {
    return PDF(
      autoSpacing: autoSpacing,
      pageFling: pageFling,
    ).cachedFromUrl(
      url,
      placeholder: (progress) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(
              color: progressIndicatorColor,
            ),
            Text('$progress %'),
          ],
        ),
      ),
      errorWidget: (error) => Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget YouTubePlayerMolecule(
      String url,
      bool hideThumbnail,
      bool showVideoProgressIndicator,
      Color progressIndicatorColor,
      Color playedColor,
      Color handleColor,
      EdgeInsetsGeometry padding) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
      flags: YoutubePlayerFlags(hideThumbnail: hideThumbnail),
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: showVideoProgressIndicator,
        progressIndicatorColor: progressIndicatorColor,
        progressColors: ProgressBarColors(
          playedColor: playedColor,
          handleColor: handleColor,
        ),
      ),
      builder: (context, player) {
        return Padding(
          padding: padding,
          child: Center(child: player),
        );
      },
    );
  }
}
