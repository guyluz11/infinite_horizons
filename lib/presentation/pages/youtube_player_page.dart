import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({
    required this.title,
    required this.url,
    super.key,
    this.topBarType = TopBarType.back,
    this.separatorVariant = SeparatorVariant.closeWidgets,
  });
  final TopBarType topBarType;
  final String title;
  final SeparatorVariant separatorVariant;
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
      body: Padding(
        padding: padding,
        child: Column(
          children: [
            if (!isFullScreen)
              TopBarMolecule(
                topBarType: widget.topBarType,
                title: widget.title,
              ),
            SeparatorAtom(variant: widget.separatorVariant),
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
      ),
    );
  }
}
