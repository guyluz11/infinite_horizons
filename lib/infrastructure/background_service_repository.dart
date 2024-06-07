part of 'package:infinite_horizons/domain/background_service_controller.dart';

class _BackgroundServiceRepository extends BackgroundServiceController {
  late FlutterBackgroundService backgroundService;
  bool supportedPlatform = true;

  @override
  Future init() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      supportedPlatform = false;
      return;
    }

    backgroundService = FlutterBackgroundService();
    backgroundService.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: (serviceInstance) {},
        isForegroundMode: true,
      ),
    );
  }
}
