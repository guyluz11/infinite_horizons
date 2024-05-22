import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerMolecule extends StatelessWidget {
  const YoutubePlayerMolecule({
    required this.url,
    super.key,
    this.hideThumbnail = false,
    this.showVideoProgressIndicator = true,
    this.progressIndicatorColor = Colors.red,
    this.playedColor = Colors.red,
    this.handleColor = Colors.red,
    this.padding = const EdgeInsets.all(8.0),
  });
  final String url;
  final bool hideThumbnail;
  final bool showVideoProgressIndicator;
  final Color progressIndicatorColor;
  final Color playedColor;
  final Color handleColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
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
