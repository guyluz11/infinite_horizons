part of 'package:infinite_horizons/domain/controllers/url_launcher_controller.dart';

class _URLLauncherRepository extends URLLauncherController {
  @override
  Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
