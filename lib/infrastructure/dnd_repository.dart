part of 'package:infinite_horizons/domain/controllers/dnd_controller.dart';

class _DndRepository extends DndController {
  // TODO: Switched packages for app to run, code not tested
  late DoNotDisturbPlugin dnd;

  @override
  void init() {
    supported = Platform.isAndroid;
    if (!supported) {
      return;
    }
    dnd = DoNotDisturbPlugin();
  }

  @override
  Future<void> enable() async {
    if (!supported) {
      return;
    }

    if (await PermissionsController.instance
        .isNotificationPolicyAccessGranted()) {
      // Turn on DND - All notifications are suppressed except priority.
      await dnd.setInterruptionFilter(InterruptionFilter.priority);
    } else {
      PermissionsController.instance.gotoPolicySettings();
    }
  }

  @override
  Future<void> disable() async {
    if (!supported) {
      return;
    }

    if (await PermissionsController.instance
        .isNotificationPolicyAccessGranted()) {
      await dnd.setInterruptionFilter(InterruptionFilter.all);
    }
  }

  @override
  Future<bool> isDnd() async {
    if (!supported) {
      return false;
    }

    return dnd.isDndEnabled();
  }

  @override
  Future<void> gotoPolicySettings() async {
    if (!supported) {
      return;
    }
    await dnd.openNotificationPolicyAccessSettings();
  }

  @override
  Future<bool> isNotificationPolicyAccessGranted() async {
    if (!supported) {
      return false;
    }
    return dnd.isNotificationPolicyAccessGranted();
  }
}
