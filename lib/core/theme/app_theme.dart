import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Theme mode state notifier
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) => state = mode;
  void toggleTheme() {
    if (state == ThemeMode.system) {
      state = ThemeMode.light;
    } else {
      state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void resetToSystem() => state = ThemeMode.system;
}

// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class AppTheme {
  static ShadThemeData darkTheme = ShadThemeData(
    colorScheme: ShadColorScheme.fromName('gray'),
    brightness: Brightness.dark,
  );
  
  static ShadThemeData lightTheme = ShadThemeData(
    colorScheme: ShadColorScheme.fromName('light'),
    brightness: Brightness.light,
  );

  // Helper method to get current theme based on mode and context
  static ShadThemeData getTheme(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.system:
        final brightness = View.of(context).platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }
}
