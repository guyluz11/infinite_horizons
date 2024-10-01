import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:universal_io/io.dart';

class PermissionsOrganism extends StatefulWidget {
  const PermissionsOrganism({this.isPageEnclosure = true});

  final bool isPageEnclosure;

  @override
  State<PermissionsOrganism> createState() => _PermissionsOrganismState();
}

class _PermissionsOrganismState extends State<PermissionsOrganism> {
  bool isLoading = true;
  bool generalNotifications = false;
  bool dndPermission = false;
  bool sleepDataPermission = false;

  @override
  void initState() {
    super.initState();
    checkPermissionsState();
  }

  Future checkPermissionsState() async {
    generalNotifications = !Platform.isAndroid &&
        await NotificationsController.instance.isPermissionGranted();

    dndPermission = await PermissionsController.instance
        .isNotificationPolicyAccessGranted();

    sleepDataPermission =
        await HealthController.instance.isPermissionsSleepInBedGranted();

    setState(() {
      isLoading = false;
    });
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CardAtom(
            child: ToggleSwitchMolecule(
              text: 'Notification Permission',
              description:
                  'Get notify about timer status when the app is in the background',
              offIcon: Icons.notifications_off_outlined,
              onIcon: Icons.notifications_outlined,
              onChange: (value) async {
                await NotificationsController.instance.generalPermission();
                await NotificationsController.instance.preciseAlarmPermission();
              },
              initialValue: generalNotifications,
              lockOnToggleOn: true,
            ),
          ),
          if (Platform.isAndroid)
            Column(
              children: [
                const SeparatorAtom(),
                CardAtom(
                  child: ToggleSwitchMolecule(
                    text: 'Do Not Disturb Mode',
                    description:
                        'Will add button for one click Do Not Disturb Mode',
                    offIcon: Icons.do_not_disturb_off_outlined,
                    onIcon: Icons.do_not_disturb_on_outlined,
                    onChange: (value) =>
                        PermissionsController.instance.gotoPolicySettings(),
                    initialValue: dndPermission,
                    lockOnToggleOn: true,
                  ),
                ),
              ],
            ),
          const SeparatorAtom(),
          if (HealthController.instance.supported)
            CardAtom(
              child: ToggleSwitchMolecule(
                text: 'Sleep Data',
                description: 'For tailored tips based on your wake hour',
                offIcon: FontAwesomeIcons.moon,
                onIcon: FontAwesomeIcons.solidMoon,
                onChange: (value) {
                  if (value) {
                    HealthController.instance.requestSleepDataPermission();
                    return;
                  }
                  HealthController.instance.removeSleepPermission();
                },
                initialValue: sleepDataPermission,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPageEnclosure) {
      return body();
    }

    return PageEnclosureMolecule(
      scaffold: false,
      title: 'Manage Permissions',
      child: isLoading ? const CircularProgressIndicator() : body(),
    );
  }
}
