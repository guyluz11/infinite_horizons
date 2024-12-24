import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/core/color_schemes.dart';
import 'package:infinite_horizons/presentation/core/global_variables.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
    final TextTheme textTheme = createTextTheme(context, 'Arya', 'Arya');

    final MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: GlobalVariables.appName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashPage(),
    );
  }
}
