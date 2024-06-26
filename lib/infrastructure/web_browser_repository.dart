part of 'package:infinite_horizons/domain/controllers/web_browser_controller.dart';

class _WebBrowserRepository extends WebBrowserController {
  @override
  Future<bool> lunchLink(String url) => launchUrl(Uri.parse(url));
}
