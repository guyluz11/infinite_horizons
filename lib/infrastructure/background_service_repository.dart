part of 'package:infinite_horizons/domain/background_service_controller.dart';

class _BackgroundServiceRepository extends BackgroundServiceController {
  late FlutterBackgroundService service;
  bool supportedPlatform = true;

  @override
  Future init() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      supportedPlatform = false;
      return;
    }
    service = FlutterBackgroundService();
    service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
      ),
    );
  }

  @override
  void startIterateTimerStates() => service.invoke('startIterateTimerStates');

  @override
  void stopIterateTimerStates() {
    // TODO: implement stopIterateTimerStates
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  // final log = preferences.getStringList('log') ?? <String>[];
  // log.add(DateTime.now().toIso8601String());
  // await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  PlayerController.instance.init();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on('startIterateTimerStates').listen((event) {
    Timer(const Duration(seconds: 3), () async {
      PlayerController.instance.play('start_session.wav');
    });
  });
}
