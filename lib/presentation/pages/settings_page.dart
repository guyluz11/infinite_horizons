import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/organisms/organisms.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PreferencesController _prefs = PreferencesController.instance;
  bool lockScreen = true;

  @override
  void initState() {
    super.initState();
    lockScreen = _prefs.getBool(PreferenceKeys.isLockScreen) ?? lockScreen;
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'settings',
      child: SingleChildScrollView(
        child: Column(
          children: [
            CardAtom(
              child: ToggleSwitchMolecule(
                text: 'sound',
                description: 'Allow app to play sound effects',
                offIcon: Icons.music_off_rounded,
                onIcon: Icons.music_note_rounded,
                onChange: (bool value) {
                  PlayerController.instance.setIsSound(value);
                  _prefs.setBool(PreferenceKeys.isSound, value);
                },
                initialValue: PlayerController.instance.isSound(),
              ),
            ),
            const SeparatorAtom(),
            CardAtom(
              child: ToggleSwitchMolecule(
                text: 'screen_lock',
                description: 'When on screen will not get locked on timer page',
                offIcon: Icons.lock_clock,
                onIcon: Icons.lock_open,
                onChange: (bool value) {
                  lockScreen = value;
                  _prefs.setBool(PreferenceKeys.isLockScreen, lockScreen);
                  WakeLockController.instance.setWakeLock(lockScreen);
                },
                initialValue: lockScreen,
              ),
            ),
            const SeparatorAtom(),
            const PermissionsOrganism(isPageEnclosure: false),
            const SeparatorAtom(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonAtom(
                  variant: ButtonVariant.lowEmphasisIcon,
                  onPressed: () => WebBrowserController.instance.lunchLink(
                    'https://github.com/guyluz11/infinite_horizons/issues',
                  ),
                  icon: FontAwesomeIcons.circleDot,
                ),
                ButtonAtom(
                  variant: ButtonVariant.lowEmphasisIcon,
                  onPressed: () => WebBrowserController.instance.lunchLink(
                      'https://github.com/guyluz11/infinite_horizons'),
                  icon: FontAwesomeIcons.github,
                ),
              ],
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
          ],
        ),
      ),
    );
  }
}
