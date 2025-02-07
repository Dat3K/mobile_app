import '../services/logger_service.dart';

/// Mixin cung cấp các phương thức logging cho các class
mixin LoggerMixin {
  final _logger = LoggerService();

  /// Log debug message
  void logDebug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d('[$runtimeType] $message', error, stackTrace);
  }

  /// Log info message
  void logInfo(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i('[$runtimeType] $message', error, stackTrace);
  }

  /// Log warning message
  void logWarning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w('[$runtimeType] $message', error, stackTrace);
  }

  /// Log error message
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('[$runtimeType] $message', error, stackTrace);
  }
}
