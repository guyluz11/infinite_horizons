import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/url_launcher_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  bool isFullScreen = false;
  EdgeInsetsGeometry get padding {
    if (isFullScreen) {
      return EdgeInsets.zero;
    }
    return GlobalVariables.defaultPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (!isFullScreen)
            TopBarMolecule(
              topBarType: TopBarType.back,
              title: 'resource',
              rightIcon: Icons.open_in_new,
              rightOnTap: () =>
                  URLLauncherController.instance.openUrl(widget.url),
            ),
          const SeparatorAtom(variant: SeparatorVariant.closeWidgets),
          Expanded(
            child: YoutubePlayerMolecule(
              url: widget.url,
              callback: (bool ytFullScreen) {
                setState(() {
                  isFullScreen = ytFullScreen;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
