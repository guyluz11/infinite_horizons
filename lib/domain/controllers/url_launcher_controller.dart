import 'package:url_launcher/url_launcher.dart';

part 'package:infinite_horizons/infrastructure/url_launcher_repository.dart';

abstract class URLLauncherController {
  static URLLauncherController? _instance;

  static URLLauncherController get instance =>
      _instance ??= _URLLauncherRepository();

  Future<void> openUrl(String url);
}
