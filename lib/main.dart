import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/router/router.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/theme/app_theme.dart';
import 'package:mobile_app/core/widgets/debug_menu.dart';
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
      builder: (context, child) {
        // Wrap với DevicePreview trong debug mode
        Widget app = DevicePreview.appBuilder(context, child);

        // Thêm debug menu trong debug mode
        if (kDebugMode) {
          app = Scaffold(
            body: Stack(
              children: [
                app,
                Positioned(
                  right: 0,
                  top: 100,
                  child: Builder(
                    builder: (context) => DebugButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
            endDrawer: const DebugMenu(),
          );
        }

        return app;
      },
    );
  }
}

/// Button để mở debug menu
class DebugButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DebugButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: const Icon(
            Icons.bug_report,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
