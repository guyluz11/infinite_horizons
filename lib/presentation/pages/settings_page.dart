import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/wake_lock_controller.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';

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
    lockScreen = _prefs.getBool("isLockScreen") ?? lockScreen;
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'settings',
      child: Column(
        children: [
          CardAtom(
            child: ToggleSwitchMolecule(
              text: 'sound',
              offIcon: Icons.music_off_rounded,
              onIcon: Icons.music_note_rounded,
              onChange: (bool value) {
                PlayerController.instance.setIsSound(value);
                _prefs.setBool("isSound", value);
              },
              initialValue: PlayerController.instance.isSound(),
            ),
          ),
          const SeparatorAtom(),
          CardAtom(
            child: ToggleSwitchMolecule(
              text: 'screen_lock',
              offIcon: Icons.lock_clock,
              onIcon: Icons.lock_open,
              onChange: (bool value) {
                lockScreen = value;
                _prefs.setBool("isLockScreen", lockScreen);
                WakeLockController.instance.setWakeLock(lockScreen);
              },
              initialValue: lockScreen,
            ),
          ),
          const SeparatorAtom(
            variant: SeparatorVariant.farApart,
          ),
        ],
      ),
    );
  }
}
