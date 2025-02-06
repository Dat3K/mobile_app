import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/dio_client.dart';
import '../network/http_client_interface.dart';

final apiClientProvider = Provider<IHttpClient>((ref) {
  return DioClient();
});
