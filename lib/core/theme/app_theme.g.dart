// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentThemeModeHash() => r'65ad36ad1c0fc42a7449f085d6f2de365cf24c07';

/// Provider cho current theme mode
///
/// Copied from [currentThemeMode].
@ProviderFor(currentThemeMode)
final currentThemeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  currentThemeMode,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$currentColorSchemeNameHash() =>
    r'c2cd6aacb87737bdbcc4ddd6c7cc942a31b385ef';

/// Provider cho current color scheme name
///
/// Copied from [currentColorSchemeName].
@ProviderFor(currentColorSchemeName)
final currentColorSchemeNameProvider = AutoDisposeProvider<String>.internal(
  currentColorSchemeName,
  name: r'currentColorSchemeNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentColorSchemeNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentColorSchemeNameRef = AutoDisposeProviderRef<String>;
String _$currentThemeHash() => r'bc86371a98de68af4f20e18cbb38c6d0971a8242';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider cho theme data - không truyền trực tiếp BuildContext
///
/// Copied from [currentTheme].
@ProviderFor(currentTheme)
const currentThemeProvider = CurrentThemeFamily();

/// Provider cho theme data - không truyền trực tiếp BuildContext
///
/// Copied from [currentTheme].
class CurrentThemeFamily extends Family<ShadThemeData> {
  /// Provider cho theme data - không truyền trực tiếp BuildContext
  ///
  /// Copied from [currentTheme].
  const CurrentThemeFamily();

  /// Provider cho theme data - không truyền trực tiếp BuildContext
  ///
  /// Copied from [currentTheme].
  CurrentThemeProvider call(
    Brightness brightness,
  ) {
    return CurrentThemeProvider(
      brightness,
    );
  }

  @override
  CurrentThemeProvider getProviderOverride(
    covariant CurrentThemeProvider provider,
  ) {
    return call(
      provider.brightness,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentThemeProvider';
}

/// Provider cho theme data - không truyền trực tiếp BuildContext
///
/// Copied from [currentTheme].
class CurrentThemeProvider extends AutoDisposeProvider<ShadThemeData> {
  /// Provider cho theme data - không truyền trực tiếp BuildContext
  ///
  /// Copied from [currentTheme].
  CurrentThemeProvider(
    Brightness brightness,
  ) : this._internal(
          (ref) => currentTheme(
            ref as CurrentThemeRef,
            brightness,
          ),
          from: currentThemeProvider,
          name: r'currentThemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentThemeHash,
          dependencies: CurrentThemeFamily._dependencies,
          allTransitiveDependencies:
              CurrentThemeFamily._allTransitiveDependencies,
          brightness: brightness,
        );

  CurrentThemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
  }) : super.internal();

  final Brightness brightness;

  @override
  Override overrideWith(
    ShadThemeData Function(CurrentThemeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentThemeProvider._internal(
        (ref) => create(ref as CurrentThemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ShadThemeData> createElement() {
    return _CurrentThemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentThemeProvider && other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentThemeRef on AutoDisposeProviderRef<ShadThemeData> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _CurrentThemeProviderElement
    extends AutoDisposeProviderElement<ShadThemeData> with CurrentThemeRef {
  _CurrentThemeProviderElement(super.provider);

  @override
  Brightness get brightness => (origin as CurrentThemeProvider).brightness;
}

String _$themeConfigNotifierHash() =>
    r'5f2cdd2a5323be63efb5d5a1aaeba3656ee8e717';

/// Notifier để quản lý theme configuration
///
/// Copied from [ThemeConfigNotifier].
@ProviderFor(ThemeConfigNotifier)
final themeConfigNotifierProvider =
    AutoDisposeNotifierProvider<ThemeConfigNotifier, ThemeConfig>.internal(
  ThemeConfigNotifier.new,
  name: r'themeConfigNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeConfigNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeConfigNotifier = AutoDisposeNotifier<ThemeConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
