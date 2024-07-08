import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:infinite_horizons/presentation/core/color_schemes.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesController.instance.init();
  PlayerController.instance.init();
  await VibrationController.instance.init();
  await EasyLocalization.ensureInitialized();
  DndController.instance.init();
  NotificationsController.instance.init();
  HealthController.instance.init();
  final int loginCounter =
      PreferencesController.instance.getInt(PreferenceKeys.loginCounter) ?? 0;
  PreferencesController.instance
      .setInt(PreferenceKeys.loginCounter, loginCounter + 1);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('he', 'IL'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Arya", "Arya");

    final MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: 'Infinite Horizons',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: IntroPage(),
    );
  }
}
