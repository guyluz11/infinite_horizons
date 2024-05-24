import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

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
  late final CustomTimerController controller = CustomTimerController(
    vsync: this,
    begin: Duration.zero,
    end: const Duration(minutes: 100),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int getDecimalPart(double number) {
    final String numberString = number.toString();
    final List<String> parts = numberString.split('.');
    if (parts.length < 2) {
      return 0;
    }
    final String decimalPart = parts[1];
    final int decimalAsInt = int.parse(decimalPart);
    return decimalAsInt;
  }

  @override
  Widget build(BuildContext context) {
    return const PDF().cachedFromUrl(
      widget.url,
      placeholder: (progress) {
        controller.jumpTo(
          Duration(
            minutes: progress.round(),
            seconds: getDecimalPart(progress),
          ),
        );
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerAtom(controller, const Duration(minutes: 100), () {}),
              const SeparatorAtom(
                variant: SeparatorVariant.closeWidgets,
              ),
              TextAtom(
                '$progress%',
                translate: false,
              ),
            ],
          ),
        );
      },
      errorWidget: (error) => const Center(
        child: TextAtom("error_pdf"),
      ),
    );
  }
}
