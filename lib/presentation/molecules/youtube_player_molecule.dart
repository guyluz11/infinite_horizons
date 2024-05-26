import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class YoutubePlayerMolecule extends StatefulWidget {
  YoutubePlayerMolecule({required this.url, super.key});
  final String url;
  bool isFullScreen = false;

  @override
  State<YoutubePlayerMolecule> createState() => _YoutubePlayerMoleculeState();
}

class _YoutubePlayerMoleculeState extends State<YoutubePlayerMolecule> {
  late final YoutubePlayerController controller;
  void listener() {
    widget.isFullScreen = controller.value.isFullScreen;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
          body: Column(
            children: [
              if (widget.isFullScreen)
                const SizedBox()
              else
                const TopBarMolecule(
                  title: "resource",
                  topBarType: TopBarType.back,
                ),
              const SeparatorAtom(
                variant: SeparatorVariant.closeWidgets,
              ),
              Expanded(child: Center(child: player)),
            ],
          ),
        );
      },
    );
  }
}
