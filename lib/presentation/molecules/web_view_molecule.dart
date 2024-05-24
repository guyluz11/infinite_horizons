import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewMolecule extends StatelessWidget {
  const WebViewMolecule({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
    );
  }
}
