import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme.g.dart';
part 'app_theme.freezed.dart';

/// Theme configuration model
@freezed
class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    required ThemeMode mode,
    required String colorSchemeName,
  }) = _ThemeConfig;

  static const defaultConfig = ThemeConfig(
    mode: ThemeMode.system,
    colorSchemeName: 'rose',
  );
}

/// Theme color schemes
class ThemeColorSchemes {
  static const Map<String, ({
    ShadColorScheme Function() light,
    ShadColorScheme Function() dark
  })> schemes = {
    'rose': (
      light: ShadRoseColorScheme.light,
      dark: ShadRoseColorScheme.dark,
    ),
    'blue': (
      light: ShadBlueColorScheme.light,
      dark: ShadBlueColorScheme.dark,
    ),
    'green': (
      light: ShadGreenColorScheme.light,
      dark: ShadGreenColorScheme.dark,
    ),
    // Thêm các color schemes khác nếu cần
  };
}

/// Notifier để quản lý theme configuration
@riverpod
class ThemeConfigNotifier extends _$ThemeConfigNotifier {
  @override
  ThemeConfig build() => ThemeConfig.defaultConfig;

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setColorScheme(String name) {
    if (ThemeColorSchemes.schemes.containsKey(name)) {
      state = state.copyWith(colorSchemeName: name);
    }
  }
  
  void toggleTheme() {
    final mode = switch (state.mode) {
      ThemeMode.system => ThemeMode.system,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
    };
    setThemeMode(mode);
  }

  void resetToSystem() => setThemeMode(ThemeMode.system);
}

/// Provider cho current theme mode
@riverpod
ThemeMode currentThemeMode(Ref ref) {
  return ref.watch(themeConfigNotifierProvider.select((config) => config.mode));
}

/// Provider cho current color scheme name
@riverpod
String currentColorSchemeName(Ref ref) {
  return ref.watch(themeConfigNotifierProvider.select((config) => config.colorSchemeName));
}

/// Provider cho theme data - không truyền trực tiếp BuildContext
@riverpod
ShadThemeData currentTheme(Ref ref, Brightness brightness) {
  final config = ref.watch(themeConfigNotifierProvider);
  final colorScheme = ThemeColorSchemes.schemes[config.colorSchemeName];
  
  if (colorScheme == null) {
    throw Exception('Color scheme ${config.colorSchemeName} not found');
  }

  // Xác định dark mode dựa trên cấu hình và brightness hệ thống
  final isDark = switch (config.mode) {
    ThemeMode.dark => true,
    ThemeMode.light => false,
    ThemeMode.system => brightness == Brightness.dark,
  };

  return ShadThemeData(
    colorScheme: isDark ? colorScheme.dark() : colorScheme.light(),
    brightness: isDark ? Brightness.dark : Brightness.light,
  );
}

/// Extension methods cho theme
extension ThemeConfigX on ThemeConfig {
  bool get isDarkMode => mode == ThemeMode.dark;
  bool get isLightMode => mode == ThemeMode.light;
  bool get isSystemMode => mode == ThemeMode.system;
}

