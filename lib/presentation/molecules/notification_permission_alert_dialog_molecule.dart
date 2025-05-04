import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

void requestNotificationPermissionPopup(BuildContext context) {
  openAlertDialog(
    context,
    _NotificationPopup(),
  );
}

class _NotificationPopup extends StatefulWidget {
  @override
  State<_NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<_NotificationPopup> {
  bool generalNotifications = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkPermissionsState();
  }

  Future checkPermissionsState() async {
    generalNotifications = !Platform.isAndroid &&
        await NotificationsController.instance.isPermissionGranted();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PageEnclosureMolecule(
        title: 'Notification Permission',
        expendChild: false,
        subTitle:
            'Please approve the permission in order for the app to work properly',
        child: CardAtom(
          child: isLoading
              ? const ProgressIndicatorAtom(totalDuration: Duration(seconds: 3))
              : ToggleSwitchMolecule(
                  text: 'Notification Permission',
                  description:
                      'Get notified about timer status when the app is in the background',
                  offIcon: Icons.notifications_off_outlined,
                  onIcon: Icons.notifications_outlined,
                  onChange: (value) async {
                    await NotificationsController.instance.generalPermission();
                    await NotificationsController.instance
                        .preciseAlarmPermission();
                  },
                  initialValue: generalNotifications,
                  lockOnToggleOn: true,
                ),
        ),
      ),
    );
  }
}
