import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerMolecule extends StatefulWidget {
  const YoutubePlayerMolecule({
    required this.url,
    required this.callback,
    super.key,
  });
  final String url;
  final Function(bool) callback;

  @override
  State<YoutubePlayerMolecule> createState() => _YoutubePlayerMoleculeState();
}

class _YoutubePlayerMoleculeState extends State<YoutubePlayerMolecule> {
  late final YoutubePlayerController controller;
  void listener() {
    widget.callback(controller.value.isFullScreen);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(hideThumbnail: true),
    )..addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: colorScheme.outline,
        progressColors: ProgressBarColors(
          playedColor: colorScheme.outline,
          handleColor: colorScheme.outline,
          backgroundColor: colorScheme.primary,
        ),
      ),
      builder: (context, player) {
        return Center(child: player);
      },
    );
  }
}
