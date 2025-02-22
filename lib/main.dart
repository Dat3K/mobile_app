import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import 'package:mobile_app/core/router/router.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/theme/app_theme.dart';
import 'package:mobile_app/features/auth/data/models/user_model.dart';
import 'package:mobile_app/features/auth/data/models/user_role_model.dart';
import 'package:mobile_app/features/auth/presentation/providers/storage_providers.dart';
import 'package:mobile_app/features/enterprise/data/models/enterprise_position_model.dart';
import 'package:mobile_app/features/event/data/models/event_model.dart';
import 'package:mobile_app/features/event/data/models/event_status_model.dart';
import 'package:mobile_app/features/event/data/models/event_type_model.dart';
import 'package:mobile_app/features/event/data/models/participation_role_model.dart';
import 'package:mobile_app/features/event/data/models/participation_status_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  try {
    // Ensure proper binding initialization
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    // Ensure path_provider is initialized
    if (!kIsWeb) {
      await getApplicationDocumentsDirectory();
    }

    // Create ProviderContainer for initialization
    final container = ProviderContainer();

    // Initialize Hive storage service
    final storageService = container.read(hiveStorageServiceProvider);
    await storageService.init();

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
          child: UncontrolledProviderScope(
            container: container,
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
    final themeMode = ref.watch(currentThemeModeProvider);
    final theme = ref.watch(currentThemeProvider(context));

    return ShadApp.materialRouter(
      title: 'Mobile-app',
      theme: theme,
      themeMode: themeMode,
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
