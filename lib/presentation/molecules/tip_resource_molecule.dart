import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/atoms/separator_atom.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

bool isFullScreen = false;

//IF CALLING FOR YOUTUBE PLAYER, SET YOUTUBE TO TRUE AND PASS URL
class TipResourceMolecule extends StatefulWidget {
  const TipResourceMolecule({
    this.innerWidget,
    required this.title,
    super.key,
    this.topBarType = TopBarType.back,
    this.separatorVariant = SeparatorVariant.closeWidgets,
    this.isYouTube = false,
    this.url,
  });
  final Widget? innerWidget;
  final TopBarType topBarType;
  final String title;
  final SeparatorVariant separatorVariant;
  final bool isYouTube;
  final String? url;
  @override
  State<TipResourceMolecule> createState() => _TipResourceMoleculeState();
}

class _TipResourceMoleculeState extends State<TipResourceMolecule> {
  EdgeInsetsGeometry get padding {
    if (isFullScreen) {
      return EdgeInsets.zero;
    }
    return GlobalVariables.defaultPadding;
  }

  void listener() {
    setState(() {});
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
                child: widget.isYouTube
                    ? YoutubePlayerMolecule(
                        url: widget.url!,
                        callback: () {
                          setState(() {});
                        },
                      )
                    : widget.innerWidget!),
          ],
        ),
      ),
    );
  }
}
