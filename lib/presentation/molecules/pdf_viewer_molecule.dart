import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';

class PdfViewerMolecule extends StatelessWidget {
  const PdfViewerMolecule({
    required this.url,
    super.key,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    return const PDF(
      
    ).cachedFromUrl(
      url,
      placeholder: (progress) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(
              color: colorScheme.primary,
            ),
            TextAtom('$progress %'),
          ],
        ),
      ),
      errorWidget: (error) => Center(
        child: TextAtom(error.toString()),
      ),
    );
  }
}
