import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

Future<void> toggleDND(BuildContext contect) async {
  if (Platform.isAndroid) {
    bool filter = await FlutterDnd.getCurrentInterruptionFilter() ==
        FlutterDnd.INTERRUPTION_FILTER_PRIORITY;
    if (await FlutterDnd.isNotificationPolicyAccessGranted ?? false) {
      await FlutterDnd.setInterruptionFilter(
        filter
            ? FlutterDnd.INTERRUPTION_FILTER_ALL
            : FlutterDnd.INTERRUPTION_FILTER_PRIORITY,
      ); // Turn on DND - All notifications are suppressed.
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  } else {}
}
