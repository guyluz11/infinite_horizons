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
        autoStart: false,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: false,
      ),
    );
  }

  @override
  Future<bool> startService() => service.startService();

  @override
  void stopService() => service.invoke('stopService');

  @override
  void startIterateTimerStates(
    TipType tipType,
    EnergyType energyType,
    TimerState timerState,
    Duration remainingTime,
  ) =>
      service.invoke(
        'startIterateTimerStates',
        //     {
        //   'tipType': tipType.name,
        //   'energyType': energyType.name,
        //   'timerState': timerState.name,
        //   'remainingTime': 'remainingTime',
        // }
      );

  @override
  void stopIterateTimerStates() {
    // TODO: implement stopIterateTimerStates
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();

    return true;
  }

  @pragma('vm:entry-point')
  static Future onStart(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    PlayerController.instance.init();

    service.on('stopService').listen((event) {
      PreferencesController.instance
          .setString('timerState', TimerStateManager.state.name);
      PreferencesController.instance.setDuration(
        'remainingTimerTime',
        TimerStateManager.getRemainingTime(),
      );
      service.stopSelf();
    });

    service.on('startIterateTimerStates').listen((event) async {
      await PreferencesController.instance.init();
      await PreferencesController.instance.reload();
      await VibrationController.instance.init();
      PlayerController.instance.init();

      // final TipType tipType= event!['tipType'] as TipType;
      //     final EnergyType energyType = event['energyType'] as EnergyType;
      // final TimerState timerState= event['timerState'] as TimerState;
      // final Duration remainingTime= event['remainingTime'] as Duration;

      final TimerState state = TimerStateExtension.fromString(
        PreferencesController.instance.getString('timerState') ?? '',
      );
      TimerStateManager.state = state;

      final Duration remainingTime =
          PreferencesController.instance.getDuration('remainingTimerTime') ??
              Duration.zero;
      final TipType selectedType = TipTypeExtension.fromString(
        PreferencesController.instance.getString('tipType') ?? '',
      );
      StudyTypeAbstract.instance = selectedType == TipType.analytical
          ? StudyTypeAnalytical()
          : StudyTypeCreatively();

      final EnergyType energy = EnergyTypeExtension.fromString(
        PreferencesController.instance.getString('energyType') ?? '',
      );

      StudyTypeAbstract.instance!.setTimerStates(energy);

      TimerStateManager.callback = () async {
        final TimerState currentState = TimerStateManager.state;
        PreferencesController.instance
            .setString('timerState', currentState.name);
        logger.i('Service saved timerState $currentState');

        if (currentState != TimerState.readyToStart) {
          return;
        }
        PreferencesController.instance.setDuration(
          'remainingTimerTime',
          TimerStateManager.getRemainingTime(),
        );
        await Future.delayed(const Duration(seconds: 5));
        logger.i('Kill process');
        service.stopSelf();
      };

      TimerStateManager.iterateOverTimerStates(remainingTime: remainingTime);
    });
  }
}
