import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/router/router.dart';

part 'navigation_service.g.dart';

/// Provider cho NavigationService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
NavigationService navigationService(Ref ref) {
  final router = ref.watch(routerProvider);
  return NavigationService(router: router);
}

/// Service để quản lý navigation trong ứng dụng
class NavigationService {
  final GoRouter _router;

  NavigationService({
    required GoRouter router,
  }) : _router = router;

  /// Navigate đến route với name
  void goNamed(
    String name, {
    Map<String, String>? params,
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: params ?? {},
      queryParameters: queryParams ?? {},
      extra: extra,
    );
  }

  /// Navigate đến route với path
  void go(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.go(
      path,
      extra: extra,
    );
  }

  /// Push route mới với name
  void pushNamed(
    String name, {
    Map<String, String>? params,
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.pushNamed(
      name,
      pathParameters: params ?? {},
      queryParameters: queryParams ?? {},
      extra: extra,
    );
  }

  /// Push route mới với path
  void push(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.push(
      path,
      extra: extra,
    );
  }

  /// Pop route hiện tại
  void pop<T extends Object?>([T? result]) {
    _router.pop(result);
  }

  /// Replace route hiện tại
  void replace(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.replace(
      path,
      extra: extra,
    );
  }

  /// Replace route hiện tại với named route
  void replaceNamed(
    String name, {
    Map<String, String>? params,
    Map<String, dynamic>? queryParams,
    Object? extra,
  }) {
    _router.replaceNamed(
      name,
      pathParameters: params ?? {},
      queryParameters: queryParams ?? {},
      extra: extra,
    );
  }

  /// Kiểm tra xem có thể pop không
  bool canPop() => _router.canPop();

  /// Lấy location hiện tại
  String get currentLocation => 
    _router.routerDelegate.currentConfiguration.uri.toString();
} 