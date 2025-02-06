import 'package:dio/dio.dart';

/// Custom exception class cho HTTP errors
class HttpError implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  final StackTrace? stackTrace;

  const HttpError({
    required this.message,
    this.statusCode,
    this.data,
    this.stackTrace,
  });

  @override
  String toString() => 'HttpError: $message (Status Code: $statusCode)';

  /// Factory constructor để tạo error từ response
  factory HttpError.fromResponse(Response? response, [StackTrace? stackTrace]) {
    return HttpError(
      message: response?.statusMessage ?? 'Unknown error occurred',
      statusCode: response?.statusCode,
      data: response?.data,
      stackTrace: stackTrace,
    );
  }

  /// Factory constructor cho network errors
  factory HttpError.network([String? message]) {
    return HttpError(
      message: message ?? 'Network error occurred',
      statusCode: null,
    );
  }

  /// Factory constructor cho timeout errors
  factory HttpError.timeout() {
    return const HttpError(
      message: 'Request timeout',
      statusCode: null,
    );
  }
}
