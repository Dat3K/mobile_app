import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/core/error/error_handler.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/router/router.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_service.g.dart';

/// Service to handle app navigation
class NavigationService {
  final GoRouter _router;
  final LoggerService _logger;
  final ErrorHandler _errorHandler;

  NavigationService({
    required GoRouter router,
    required LoggerService logger,
    required ErrorHandler errorHandler,
  })  : _router = router,
        _logger = logger,
        _errorHandler = errorHandler;

  /// Push a new route
  Future<void> push(String path, {Map<String, String>? params, Object? extra}) async {
    try {
      _logger.i('Navigating to: $path');
      _router.push(
        _buildPath(path, params),
        extra: extra,
      );
    } catch (e, stackTrace) {
      _logger.e('Error navigating to $path: $e');
      _errorHandler.handleException(
        NavigationFailure('Failed to navigate to $path: ${e.toString()}'),
        stackTrace,
      );
    }
  }

  /// Replace the current route
  Future<void> replace(String path, {Map<String, String>? params, Object? extra}) async {
    try {
      _logger.i('Replacing route with: $path');
      _router.go(
        _buildPath(path, params),
        extra: extra,
      );
    } catch (e, stackTrace) {
      _logger.e('Error replacing route with $path: $e');
      _errorHandler.handleException(
        NavigationFailure('Failed to navigate to $path: ${e.toString()}'),
        stackTrace,
      );
    }
  }

  /// Go back to the previous route
  void pop<T>([T? result]) {
    try {
      _logger.i('Popping current route');
      _router.pop(result);
    } catch (e, stackTrace) {
      _logger.e('Error popping route: $e');
      _errorHandler.handleException(
        NavigationFailure('Failed to go back: ${e.toString()}'),
        stackTrace,
      );
    }
  }

  /// Check if can go back
  bool canPop() {
    return _router.canPop();
  }

  /// Get the current route path
  String getCurrentPath() {
    return _router.routerDelegate.currentConfiguration.uri.toString();
  }

  /// Build a path with optional query parameters
  String _buildPath(String path, Map<String, String>? params) {
    if (params == null || params.isEmpty) {
      return path;
    }

    // Add query parameters
    final uri = Uri.parse(path);
    final queryParams = Map<String, String>.from(uri.queryParameters)
      ..addAll(params);
    return Uri(
      path: uri.path,
      queryParameters: queryParams,
    ).toString();
  }

  /// Reset to login route (for logout)
  Future<void> resetToLogin() async {
    try {
      _router.go(RoutePaths.login);
    } catch (e, stackTrace) {
      _logger.e('Error resetting to login: $e');
      _errorHandler.handleException(
        NavigationFailure('Failed to reset to login: ${e.toString()}'),
        stackTrace,
      );
    }
  }
}

/// Custom navigation failure
class NavigationFailure extends Failure {
  const NavigationFailure(super.message);
}

/// Provider for the navigation service
@riverpod
NavigationService navigationService(Ref ref) {
  final router = ref.watch(routerProvider);
  final logger = ref.watch(loggerServiceProvider);
  final errorHandler = ref.watch(errorHandlerProvider.notifier);
  
  return NavigationService(
    router: router,
    logger: logger,
    errorHandler: errorHandler,
  );
} 