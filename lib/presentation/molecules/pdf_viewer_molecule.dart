import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';

class PdfViewerMolecule extends StatefulWidget {
  const PdfViewerMolecule({
    required this.url,
    super.key,
  });
  final String url;
  @override
  State<PdfViewerMolecule> createState() => _PdfViewerMoleculeState();
}

class _PdfViewerMoleculeState extends State<PdfViewerMolecule>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PDF().cachedFromUrl(
      widget.url,
      placeholder: (progress) {
        controller!.animateTo(progress / 100, duration: Duration.zero);
        return Padding(
          padding: GlobalVariables.defaultPadding,
          child: Center(
            child: ProgressIndicatorAtom(
              totalDuration: const Duration(seconds: 100),
              inputController: controller,
              isPdfLoader: true,
              centerWidget: TextAtom(
                '${(controller!.value * 100).toInt()}%',
                translate: false,
              ),
            ),
          ),
        );
      },
      errorWidget: (error) => const Center(
        child: TextAtom('error_pdf'),
      ),
    );
  }
}
