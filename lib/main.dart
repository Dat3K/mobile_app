import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/core/router/router.dart';
import 'package:mobile_app/core/theme/app_theme.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';
import 'package:mobile_app/features/auth/data/models/user_role_model.dart';
import 'package:mobile_app/features/auth/presentation/providers/storage_providers.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  // Ensure proper binding initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Ensure path_provider is initialized
  if (!kIsWeb) {
    await getApplicationDocumentsDirectory();
  }

  try {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register Adapters with error handling
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserRoleModelAdapter());
    }

    // Open Hive Boxes with error handling
    final userBox = await Hive.openBox<UserModel>('user');

    // Set up error handlers for async errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    runApp(
      DevicePreview(
        enabled: kDebugMode && kIsWeb,
        builder: (context) => EasyLocalization(
          supportedLocales: const [
            Locale('vi', 'VN'),
            Locale('en', 'US'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('vi', 'VN'),
          child: ProviderScope(
            overrides: [
              userBoxProvider.overrideWithValue(userBox),
            ],
            child: const MyApp(),
          ),
        ),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error during initialization: $e\n$stackTrace');
    rethrow;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return ShadApp.materialRouter(
      title: 'Mobile-app',
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: DevicePreview.appBuilder,
    );
  }
}
