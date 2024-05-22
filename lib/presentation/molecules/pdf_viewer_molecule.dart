import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewerMolecule extends StatelessWidget {
  const PdfViewerMolecule(
      {required this.url, super.key,
      this.autoSpacing = true,
      this.pageFling = true,
      this.progressIndicatorColor = Colors.blue,});
  final String url;
  final bool autoSpacing;
  final bool pageFling;
  final Color progressIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return PDF(
      autoSpacing: autoSpacing,
      pageFling: pageFling,
    ).cachedFromUrl(
      url,
      placeholder: (progress) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(
              color: progressIndicatorColor,
            ),
            Text('$progress %'),
          ],
        ),
      ),
      errorWidget: (error) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
