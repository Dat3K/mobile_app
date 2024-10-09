import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  static ShadThemeData darkTheme = ShadThemeData(
    colorScheme: const ShadSlateColorScheme.dark(),
    brightness: Brightness.dark,
  );
  static ShadThemeData lightTheme = ShadThemeData(
    colorScheme: const ShadSlateColorScheme.light(),
    brightness: Brightness.light,
  );
}
