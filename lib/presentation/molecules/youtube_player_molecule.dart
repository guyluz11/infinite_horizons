import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerMolecule extends StatefulWidget {
  const YoutubePlayerMolecule({required this.url, super.key});
  final String url;

  @override
  State<YoutubePlayerMolecule> createState() => _YoutubePlayerMoleculeState();
}

class _YoutubePlayerMoleculeState extends State<YoutubePlayerMolecule> {
  late final YoutubePlayerController controller;
  void listener() {
    setState(() {
      GlobalVariables.isFullScreen.value = controller.value.isFullScreen;
    });
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
        return Scaffold(
          body: Center(child: player),
        );
      },
    );
  }
}
