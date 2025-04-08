import 'package:dio/dio.dart';
import 'package:mobile_app/core/error/failures.dart';

/// Xử lý các exception từ Dio và chuyển đổi thành các Failure tương ứng
class DioExceptionHandler {
  /// Xử lý DioException và chuyển đổi thành Failure
  static Failure handleDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => ConnectionFailure(e.message ?? 'Request timeout'),
      
      DioExceptionType.connectionError => ConnectionFailure(e.message ?? 'Network connection error'),
      
      DioExceptionType.badResponse => _handleResponseError(e),
      
      DioExceptionType.cancel => ConnectionFailure.timeout(),
      
      DioExceptionType.badCertificate => ConnectionFailure.badCertificate(),
      
      _ => ServerFailure.internal(),
    };
  }

  /// Xử lý lỗi response dựa vào status code
  static Failure _handleResponseError(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;
    
    // Trích xuất message từ response data
    String? errorMessage;
    if (responseData is Map<String, dynamic>) {
      errorMessage = responseData['message'] as String?;
    }
    
    if (statusCode != null) {
      if (statusCode >= 500) {
        return ServerFailure(errorMessage ?? 'Server error');
      } else if (statusCode == 401) {
        return UnauthorizedFailure(errorMessage ?? 'Unauthorized');
      } else if (statusCode == 403) {
        return ForbiddenFailure(errorMessage ?? 'Access forbidden');
      } else if (statusCode == 404) {
        return HttpFailure.notFound();
      } else if (statusCode == 422 || statusCode == 400) {
        // Xử lý lỗi validation
        if (responseData is Map<String, dynamic> && responseData.containsKey('errors')) {
          // Cố gắng trích xuất mảng lỗi validation từ response
          final errors = responseData['errors'];
          if (errors is Map) {
            final errorMessages = errors.values
                .expand((e) => e is List ? e.map((m) => m.toString()) : [e.toString()])
                .join(', ');
            return ValidationFailure(errorMessages);
          }
        }
        return ValidationFailure(errorMessage ?? 'Invalid input data');
      }
    }
    
    return HttpFailure.badRequest();
  }

  /// Xử lý lỗi khi response data là null
  static Failure handleNullResponse() {
    return ServerFailure('Response data is null');
  }

  /// Xử lý lỗi không phải từ Dio
  static Failure handleNonDioError(dynamic error) {
    return ServerFailure('Request failed: ${error.toString()}');
  }
} 