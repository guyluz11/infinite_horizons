import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/color_schemes.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerMolecule extends StatelessWidget {
  YoutubePlayerMolecule({
    required this.url,
    this.hideThumbnail = false,
    this.showVideoProgressIndicator = true,
    this.progressIndicatorColor = Colors.red,
    this.playedColor = Colors.red,
    this.handleColor = Colors.red,
    this.padding = const EdgeInsets.all(8.0),
    super.key,
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
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
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
