import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  final TextTheme baseTextTheme = Theme.of(context).textTheme;
  final TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  final TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  final TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

// const lightColorScheme = ColorScheme(
//   brightness: Brightness.light,
//   primary: Color(0xFF0060AA),
//   onPrimary: Color(0xFFFFFFFF),
//   primaryContainer: Color(0xFFD3E4FF),
//   onPrimaryContainer: Color(0xFF001C38),
//   secondary: Color(0xFF006E17),
//   onSecondary: Color(0xFFFFFFFF),
//   secondaryContainer: Color(0xFF76FF74),
//   onSecondaryContainer: Color(0xFF002203),
//   tertiary: Color(0xFF524DC8),
//   onTertiary: Color(0xFFFFFFFF),
//   tertiaryContainer: Color(0xFFE2DFFF),
//   onTertiaryContainer: Color(0xFF0E006A),
//   error: Color(0xFFBA1A1A),
//   errorContainer: Color(0xFFFFDAD6),
//   onError: Color(0xFFFFFFFF),
//   onErrorContainer: Color(0xFF410002),
//   surface: Color(0xFFF9FFE8),
//   onSurface: Color(0xFF112000),
//   surfaceContainerHighest: Color(0xFFDFE2EB),
//   onSurfaceVariant: Color(0xFF43474E),
//   outline: Color(0xFF73777F),
//   onInverseSurface: Color(0xFFD4FF97),
//   inverseSurface: Color(0xFF203600),
//   inversePrimary: Color(0xFFA2C9FF),
//   shadow: Color(0xFF000000),
//   surfaceTint: Color(0xFF0060AA),
//   outlineVariant: Color(0xFFC3C6CF),
//   scrim: Color(0xFF000000),
// );
//
// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFFA2C9FF),
//   onPrimary: Color(0xFF00315C),
//   primaryContainer: Color(0xFF004882),
//   onPrimaryContainer: Color(0xFFD3E4FF),
//   secondary: Color(0xFF58E15B),
//   onSecondary: Color(0xFF003908),
//   secondaryContainer: Color(0xFF00530F),
//   onSecondaryContainer: Color(0xFF76FF74),
//   tertiary: Color(0xFFC3C0FF),
//   onTertiary: Color(0xFF20109A),
//   tertiaryContainer: Color(0xFF3932AF),
//   onTertiaryContainer: Color(0xFFE2DFFF),
//   error: Color(0xFFFFB4AB),
//   errorContainer: Color(0xFF93000A),
//   onError: Color(0xFF690005),
//   onErrorContainer: Color(0xFFFFDAD6),
//   surface: Color(0xFF112000),
//   onSurface: Color(0xFFC6F08A),
//   surfaceContainerHighest: Color(0xFF43474E),
//   onSurfaceVariant: Color(0xFFC3C6CF),
//   outline: Color(0xFF8D9199),
//   onInverseSurface: Color(0xFF112000),
//   inverseSurface: Color(0xFFC6F08A),
//   inversePrimary: Color(0xFF0060AA),
//   shadow: Color(0xFF000000),
//   surfaceTint: Color(0xFFA2C9FF),
//   outlineVariant: Color(0xFF43474E),
//   scrim: Color(0xFF000000),
// );

class MaterialTheme {
  const MaterialTheme(this.textTheme);

  final TextTheme textTheme;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff445e91),
      surfaceTint: Color(0xff445e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd8e2ff),
      onPrimaryContainer: Color(0xff001a41),
      secondary: Color(0xff565e71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdbe2f9),
      onSecondaryContainer: Color(0xff131b2c),
      tertiary: Color(0xff715574),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfffbd7fc),
      onTertiaryContainer: Color(0xff29132d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff44474f),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff131b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xfffbd7fc),
      onTertiaryFixed: Color(0xff29132d),
      tertiaryFixedDim: Color(0xffdebcdf),
      onTertiaryFixedVariant: Color(0xff583e5b),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff264273),
      surfaceTint: Color(0xff445e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5a74a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3b4355),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d7488),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff533a57),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff886b8b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff40434b),
      outline: Color(0xff5c5f67),
      outlineVariant: Color(0xff787a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff5a74a9),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff415c8e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d7488),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff545c6f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff886b8b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff6e5371),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214e),
      surfaceTint: Color(0xff445e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff264273),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1a2233),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3b4355),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff301a34),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff533a57),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21242b),
      outline: Color(0xff40434b),
      outlineVariant: Color(0xff40434b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffe6ecff),
      primaryFixed: Color(0xff264273),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0a2b5c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3b4355),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff252d3e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff533a57),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3c243f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff102f60),
      primaryContainer: Color(0xff2b4678),
      onPrimaryContainer: Color(0xffd8e2ff),
      secondary: Color(0xffbfc6dc),
      onSecondary: Color(0xff283041),
      secondaryContainer: Color(0xff3f4759),
      onSecondaryContainer: Color(0xffdbe2f9),
      tertiary: Color(0xffdebcdf),
      onTertiary: Color(0xff402843),
      tertiaryContainer: Color(0xff583e5b),
      onTertiaryContainer: Color(0xfffbd7fc),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff445e91),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff131b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xfffbd7fc),
      onTertiaryFixed: Color(0xff29132d),
      tertiaryFixedDim: Color(0xffdebcdf),
      onTertiaryFixedVariant: Color(0xff583e5b),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb3cbff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff001537),
      primaryContainer: Color(0xff7691c7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc3cae1),
      onSecondary: Color(0xff0e1626),
      secondaryContainer: Color(0xff8991a5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe2c0e3),
      onTertiary: Color(0xff230d28),
      tertiaryContainer: Color(0xffa687a8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xfffbfaff),
      onSurfaceVariant: Color(0xffc9cad4),
      outline: Color(0xffa1a2ac),
      outlineVariant: Color(0xff81838c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff2c4779),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff00102d),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff173566),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff091121),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff2e3647),
      tertiaryFixed: Color(0xfffbd7fc),
      onTertiaryFixed: Color(0xff1e0822),
      tertiaryFixedDim: Color(0xffdebcdf),
      onTertiaryFixedVariant: Color(0xff462d49),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb3cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffbfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc3cae1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe2c0e3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc9cad4),
      outlineVariant: Color(0xffc9cad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff062859),
      primaryFixed: Color(0xffdee7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb3cbff),
      onPrimaryFixedVariant: Color(0xff001537),
      secondaryFixed: Color(0xffdfe6fd),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc3cae1),
      onSecondaryFixedVariant: Color(0xff0e1626),
      tertiaryFixed: Color(0xffffdcff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffe2c0e3),
      onTertiaryFixedVariant: Color(0xff230d28),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });

  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
