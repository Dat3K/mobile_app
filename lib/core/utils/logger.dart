import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger.g.dart';

/// Provider cho LoggerService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
LoggerService loggerService(ref) {
  return LoggerService();
}

/// Interface cho LoggerService
abstract class ILoggerService {
  void d(String message, [dynamic error, StackTrace? stackTrace]);
  void i(String message, [dynamic error, StackTrace? stackTrace]);
  void w(String message, [dynamic error, StackTrace? stackTrace]);
  void e(String message, [dynamic error, StackTrace? stackTrace]);
}

/// Implementation của LoggerService
class LoggerService implements ILoggerService {
  late final Logger _logger;
  
  LoggerService() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
      // Có thể thêm các filter tùy theo môi trường
      filter: ProductionFilter(),
    );
  }

  @override
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}

/// Mock LoggerService cho testing
class MockLoggerService implements ILoggerService {
  final List<String> logs = [];

  @override
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    logs.add('DEBUG: $message');
  }

  @override
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    logs.add('INFO: $message');
  }

  @override
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    logs.add('WARN: $message');
  }

  @override
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    logs.add('ERROR: $message${error != null ? ' - Error: $error' : ''}');
  }

  /// Xóa tất cả logs
  void clearLogs() {
    logs.clear();
  }

  /// Kiểm tra xem có log nào chứa message không
  bool hasLog(String message) {
    return logs.any((log) => log.contains(message));
  }
}
