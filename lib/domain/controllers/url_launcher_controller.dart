import 'package:url_launcher/url_launcher.dart';

part 'package:infinite_horizons/infrastructure/url_launcher_repository.dart';

abstract class UrlLauncherController {
  static UrlLauncherController? _instance;

  static UrlLauncherController get instance =>
      _instance ??= _UrlLauncherRepository();

  Future<bool> openUrl(String url);
}
