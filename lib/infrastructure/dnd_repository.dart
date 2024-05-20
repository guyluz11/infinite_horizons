part of 'package:infinite_horizons/domain/dnd_controller.dart';

class _DndRepository extends DndController {
  @override
  Future<void> toggleDnd() async {
    final bool filter = await FlutterDnd.getCurrentInterruptionFilter() ==
        FlutterDnd.INTERRUPTION_FILTER_PRIORITY;
    if (await FlutterDnd.isNotificationPolicyAccessGranted ?? false) {
      // Turn on DND - All notifications are suppressed except priority.
      await FlutterDnd.setInterruptionFilter(
        filter
            ? FlutterDnd.INTERRUPTION_FILTER_ALL
            : FlutterDnd.INTERRUPTION_FILTER_PRIORITY,
      );
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }
}
