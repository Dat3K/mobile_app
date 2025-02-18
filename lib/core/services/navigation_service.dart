import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/router/router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  final router = ref.watch(routerProvider);
  return NavigationService(router);
}); 

class NavigationService {
  final GoRouter _router;

  NavigationService(this._router);

  void goNamed(String name, {Map<String, String>? params}) {
    _router.goNamed(name, pathParameters: params ?? {});
  }

  void go(String path) {
    _router.go(path);
  }

  void pushNamed(String name, {Map<String, String>? params}) {
    _router.pushNamed(name, pathParameters: params ?? {});
  }

  void push(String path) {
    _router.push(path);
  }

  void pop() {
    _router.pop();
  }

  void replace(String path) {
    _router.replace(path);
  }

  String get currentLocation => _router.routerDelegate.currentConfiguration.uri.toString();
} 