part of 'package:infinite_horizons/domain/controllers/url_launcher_controller.dart';

class _UrlLauncherRepository extends UrlLauncherController {
  @override
  Future<bool> openUrl(String url) => launchUrl(Uri.parse(url));
}
