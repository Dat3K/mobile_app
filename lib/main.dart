import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/router/router.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/theme/app_theme.dart';
import 'package:mobile_app/core/widgets/debug_menu.dart';
import 'package:mobile_app/core/widgets/error_boundary.dart';
import 'package:mobile_app/core/error/error_handler.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mobile_app/core/config/screen_util_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  try {
    // Giữ splash screen cho đến khi ứng dụng sẵn sàng
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    // Create ProviderContainer for initialization
    final container = ProviderContainer();

    // Initialize Hive storage service
    final storageService = container.read(hiveStorageServiceProvider);
    await storageService.init();

    // Set up error handlers for async errors
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log the error
      FlutterError.presentError(details);
      
      // Handle the error with our error handler
      container.read(errorHandlerProvider.notifier).handleException(
        details.exception,
        details.stack,
      );
    };

    // Set up error handler for platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      // Handle the error with our error handler
      container.read(errorHandlerProvider.notifier).handleException(
        error,
        stack,
      );
      return true;
    };

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: DevicePreview(
          enabled: kDebugMode && kIsWeb,
          builder: (context) => EasyLocalization(
            supportedLocales: const [
              Locale('vi', 'VN'),
              Locale('en', 'US'),
            ],
            path: 'assets/translations',
            fallbackLocale: const Locale('vi', 'VN'),
            child: const MyApp(),
          ),
        ),
      ),
    );

    // Sau khi ứng dụng đã khởi chạy, chúng ta có thể loại bỏ splash screen
    FlutterNativeSplash.remove();
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
    final brightness = MediaQuery.of(context).platformBrightness;
    final theme = ref.watch(currentThemeProvider(brightness));

    // Wrap the entire app with an ErrorBoundary to catch unhandled errors
    return ErrorBoundary(
      fullScreen: true,
      onRetry: () {
        // Clear errors and rebuild the app
        ref.read(errorHandlerProvider.notifier).clearError();
      },
      child: AppScreenUtil.init(
        child: ShadApp.materialRouter(
          title: 'Mobile-app',
          theme: theme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            // Watch for current errors
            final currentError = ref.watch(currentErrorProvider);
            
            // In thông tin màn hình trong debug mode
            if (kDebugMode) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppScreenUtil.reportScreenInfo(context);
              });
            }
            
            // Wrap với DevicePreview trong debug mode
            Widget app = DevicePreview.appBuilder(context, child);

            // If there's a current error in the global handler and we're not already
            // showing it via the ErrorBoundary, show an error snackbar
            if (currentError != null && child != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  ShadToaster.of(context).show(
                    ShadToast.destructive(
                      title: Text(_getErrorTitle(currentError)),
                      description: Text(currentError.message),
                      action: ShadButton.destructive(
                        child: const Text('Dismiss'),
                        onPressed: () {
                          ref.read(errorHandlerProvider.notifier).clearError();
                          ShadToaster.of(context).hide();
                        },
                      ),
                    ),
                  );
                }
              });
            }

            // Thêm debug menu trong debug mode
            if (kDebugMode) {
              app = Scaffold(
                body: Stack(
                  children: [
                    app,
                    Positioned(
                      right: 0,
                      top: 100.h,
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
        ),
      ),
    );
  }

  // Helper method to get error title based on failure type
  String _getErrorTitle(Failure failure) {
    if (failure is ConnectionFailure) return 'Connection Error';
    if (failure is ServerFailure) return 'Server Error';
    if (failure is AuthFailure) return 'Authentication Error';
    if (failure is ValidationFailure) return 'Validation Error';
    return 'Error';
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
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              bottomLeft: Radius.circular(8.r),
            ),
          ),
          child: Icon(
            Icons.bug_report,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
