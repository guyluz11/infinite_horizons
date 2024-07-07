part of 'package:infinite_horizons/domain/controllers/dnd_controller.dart';

class _DndRepository extends DndController {
  @override
  void init() {
    supported = Platform.isAndroid;
  }

  @override
  Future<void> enableDnd() async {
    if (!supported) {
      return;
    }

    if (await PermissionsController.instance
        .isNotificationPolicyAccessGranted()) {
      // Turn on DND - All notifications are suppressed except priority.
      await FlutterDnd.setInterruptionFilter(
        FlutterDnd.INTERRUPTION_FILTER_PRIORITY,
      );
    } else {
      PermissionsController.instance.gotoPolicySettings();
    }
  }

  @override
  Future<bool> isDnd() async {
    if (!supported) {
      return false;
    }

    return await FlutterDnd.getCurrentInterruptionFilter() ==
        FlutterDnd.INTERRUPTION_FILTER_PRIORITY;
  }
}
