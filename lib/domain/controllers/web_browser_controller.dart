import 'package:url_launcher/url_launcher.dart';

part 'package:infinite_horizons/infrastructure/web_browser_repository.dart';

abstract class WebBrowserController {
  static WebBrowserController? _instance;

  static WebBrowserController get instance =>
      _instance ??= _WebBrowserRepository();

  Future<bool> lunchLink(String url);
}
