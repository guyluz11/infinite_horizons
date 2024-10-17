import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/atoms/atoms.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';
import 'package:infinite_horizons/presentation/pages/welcome_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future initializeApp() async {
    await PreferencesController.instance.init();
    PlayerController.instance.init();
    await VibrationController.instance.init();
    DndController.instance.init();
    NotificationsController.instance.init();
    HealthController.instance.init();
    final int loginCounter =
        PreferencesController.instance.getInt(PreferenceKeys.loginCounter) ?? 0;
    PreferencesController.instance
        .setInt(PreferenceKeys.loginCounter, loginCounter + 1);

    _navigate();
  }

  Future _navigate() async {
    final bool finishedIntroduction = PreferencesController.instance
            .getBool(PreferenceKeys.finishedIntroduction) ??
        false;

    if (finishedIntroduction) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppThemeData.logoBackgroundColor,
        child: const Center(
          child: ImageAtom(
            'assets/logo.png',
            hero: 'full_logo',
          ),
        ),
      ),
    );
  }
}
