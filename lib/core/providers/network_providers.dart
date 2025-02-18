import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/providers/cookie_providers.dart';
import '../network/rest/csrf_interceptor.dart';
import 'security_providers.dart';

final csrfInterceptorProvider = Provider<CsrfInterceptor>((ref) {
  final dio = ref.watch(dioProvider);
  final csrfTokenService = ref.watch(csrfTokenServiceProvider);
  final cookieService = ref.watch(cookieServiceProvider);
  return CsrfInterceptor(dio, csrfTokenService, cookieService);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
}); 