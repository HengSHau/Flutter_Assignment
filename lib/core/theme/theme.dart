import "package:flutter/material.dart";

class Themes {
  final TextTheme textTheme;

  const Themes(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006874),
      surfaceTint: Color(0xff006874),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9eeffd),
      onPrimaryContainer: Color(0xff004f58),
      secondary: Color(0xff3a608f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd3e3ff),
      onSecondaryContainer: Color(0xff1f4876),
      tertiary: Color(0xff415f91),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd6e3ff),
      onTertiaryContainer: Color(0xff274777),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff82d3e0),
      primaryFixed: Color(0xff9eeffd),
      onPrimaryFixed: Color(0xff001f24),
      primaryFixedDim: Color(0xff82d3e0),
      onPrimaryFixedVariant: Color(0xff004f58),
      secondaryFixed: Color(0xffd3e3ff),
      onSecondaryFixed: Color(0xff001c39),
      secondaryFixedDim: Color(0xffa4c9fe),
      onSecondaryFixedVariant: Color(0xff1f4876),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff001b3e),
      tertiaryFixedDim: Color(0xffaac7ff),
      onTertiaryFixedVariant: Color(0xff274777),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003c44),
      surfaceTint: Color(0xff006874),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff187884),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff053764),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4a6f9f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff133665),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff506da0),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff0c1213),
      onSurfaceVariant: Color(0xff2f3839),
      outline: Color(0xff4b5456),
      outlineVariant: Color(0xff656f70),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff82d3e0),
      primaryFixed: Color(0xff187884),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005e68),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4a6f9f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff305685),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff506da0),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff375586),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7c9),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe3e9ea),
      surfaceContainerHigh: Color(0xffd8dedf),
      surfaceContainerHighest: Color(0xffcdd3d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003238),
      surfaceTint: Color(0xff006874),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00515a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002d55),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff224a78),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff032b5b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2a497a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e2f),
      outlineVariant: Color(0xff414b4c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff82d3e0),
      primaryFixed: Color(0xff00515a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00393f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff224a78),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003360),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2a497a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0e3262),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babb),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f3),
      surfaceContainer: Color(0xffdee3e5),
      surfaceContainerHigh: Color(0xffcfd5d6),
      surfaceContainerHighest: Color(0xffc2c7c9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff82d3e0),
      surfaceTint: Color(0xff82d3e0),
      onPrimary: Color(0xff00363d),
      primaryContainer: Color(0xff004f58),
      onPrimaryContainer: Color(0xff9eeffd),
      secondary: Color(0xffa4c9fe),
      onSecondary: Color(0xff00315c),
      secondaryContainer: Color(0xff1f4876),
      onSecondaryContainer: Color(0xffd3e3ff),
      tertiary: Color(0xffaac7ff),
      onTertiary: Color(0xff0a305f),
      tertiaryContainer: Color(0xff274777),
      onTertiaryContainer: Color(0xffd6e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff006874),
      primaryFixed: Color(0xff9eeffd),
      onPrimaryFixed: Color(0xff001f24),
      primaryFixedDim: Color(0xff82d3e0),
      onPrimaryFixedVariant: Color(0xff004f58),
      secondaryFixed: Color(0xffd3e3ff),
      onSecondaryFixed: Color(0xff001c39),
      secondaryFixedDim: Color(0xffa4c9fe),
      onSecondaryFixedVariant: Color(0xff1f4876),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff001b3e),
      tertiaryFixedDim: Color(0xffaac7ff),
      onTertiaryFixedVariant: Color(0xff274777),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff98e9f7),
      surfaceTint: Color(0xff82d3e0),
      onPrimary: Color(0xff002a30),
      primaryContainer: Color(0xff499ca9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc9deff),
      onSecondary: Color(0xff00264a),
      secondaryContainer: Color(0xff6e93c5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcdddff),
      onTertiary: Color(0xff002550),
      tertiaryContainer: Color(0xff7491c6),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dee0),
      outline: Color(0xffaab4b5),
      outlineVariant: Color(0xff889294),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff005059),
      primaryFixed: Color(0xff9eeffd),
      onPrimaryFixed: Color(0xff001417),
      primaryFixedDim: Color(0xff82d3e0),
      onPrimaryFixedVariant: Color(0xff003c44),
      secondaryFixed: Color(0xffd3e3ff),
      onSecondaryFixed: Color(0xff001227),
      secondaryFixedDim: Color(0xffa4c9fe),
      onSecondaryFixedVariant: Color(0xff053764),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff00112b),
      tertiaryFixedDim: Color(0xffaac7ff),
      onTertiaryFixedVariant: Color(0xff133665),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff3f4647),
      surfaceContainerLowest: Color(0xff040809),
      surfaceContainerLow: Color(0xff191f20),
      surfaceContainer: Color(0xff23292a),
      surfaceContainerHigh: Color(0xff2d3435),
      surfaceContainerHighest: Color(0xff393f40),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcdf7ff),
      surfaceTint: Color(0xff82d3e0),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7ecfdc),
      onPrimaryContainer: Color(0xff000e10),
      secondary: Color(0xffe9f0ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffa0c5fa),
      onSecondaryContainer: Color(0xff000c1d),
      tertiary: Color(0xffebf0ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa6c3fc),
      onTertiaryContainer: Color(0xff000b20),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f3),
      outlineVariant: Color(0xffbbc4c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff005059),
      primaryFixed: Color(0xff9eeffd),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff82d3e0),
      onPrimaryFixedVariant: Color(0xff001417),
      secondaryFixed: Color(0xffd3e3ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffa4c9fe),
      onSecondaryFixedVariant: Color(0xff001227),
      tertiaryFixed: Color(0xffd6e3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffaac7ff),
      onTertiaryFixedVariant: Color(0xff00112b),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff4b5152),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2122),
      surfaceContainer: Color(0xff2b3133),
      surfaceContainerHigh: Color(0xff363c3e),
      surfaceContainerHighest: Color(0xff424849),
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
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

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
