import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'error_handler.g.dart';

/// Global error handler state
class ErrorHandlerState {
  final Failure? currentError;
  final List<Failure> errorHistory;

  const ErrorHandlerState({
    this.currentError,
    this.errorHistory = const [],
  });

  ErrorHandlerState copyWith({
    Failure? currentError,
    List<Failure>? errorHistory,
  }) {
    return ErrorHandlerState(
      currentError: currentError,
      errorHistory: errorHistory ?? this.errorHistory,
    );
  }

  ErrorHandlerState clearCurrentError() {
    return ErrorHandlerState(
      currentError: null,
      errorHistory: errorHistory,
    );
  }

  ErrorHandlerState addError(Failure failure) {
    // Add to history and set as current error
    final newHistory = List<Failure>.from(errorHistory)..add(failure);
    return ErrorHandlerState(
      currentError: failure,
      errorHistory: newHistory,
    );
  }
}

/// Global error handler notifier to manage errors across the app
@riverpod
class ErrorHandler extends _$ErrorHandler {
  late final LoggerService _logger;

  @override
  ErrorHandlerState build() {
    _logger = ref.read(loggerServiceProvider);
    return const ErrorHandlerState();
  }

  /// Handle a new error
  void handleError(Failure failure, {StackTrace? stackTrace}) {
    _logger.e('Error: ${failure.message}', stackTrace);
    state = state.addError(failure);
  }

  /// Clear the current error
  void clearError() {
    state = state.clearCurrentError();
  }

  /// Get the error history
  List<Failure> getErrorHistory() {
    return state.errorHistory;
  }

  /// Helper to handle exceptions and convert them to failures
  void handleException(Object exception, [StackTrace? stackTrace]) {
    final Failure failure;
    
    if (exception is Failure) {
      failure = exception;
    } else {
      failure = ServerFailure(exception.toString());
    }
    
    handleError(failure, stackTrace: stackTrace);
  }
}

/// Provider to expose the current error
@riverpod
Failure? currentError(Ref ref) {
  return ref.watch(errorHandlerProvider).currentError;
}

/// Provider to check if there's an active error
@riverpod
bool hasError(Ref ref) {
  return ref.watch(currentErrorProvider) != null;
}

/// Extension method for GlobalKey<NavigatorState> to show error toasts
extension ErrorNavigatorExtension on GlobalKey<NavigatorState> {
  /// Show an error toast with the provided failure
  void showErrorToast(Failure failure, {String? title}) {
    final context = currentContext;
    if (context == null) return;

    // Hiển thị toast
    ShadToaster.of(context).show(
      ShadToast.destructive(
        title: Text(title ?? _getErrorTitle(failure)),
        description: Text(failure.message),
        action: ShadButton.destructive(
          child: const Text('Đóng'),
          onPressed: () {
            ShadToaster.of(context).hide();
          },
        ),
      ),
    );
  }

  // Helper method to get error title based on failure type
  String _getErrorTitle(Failure failure) {
    return switch (failure) {
      ConnectionFailure() => 'Lỗi kết nối',
      UnauthorizedFailure() => 'Không có quyền truy cập',
      ForbiddenFailure() => 'Truy cập bị từ chối',
      ValidationFailure() => 'Dữ liệu không hợp lệ',
      HttpFailure() => 'Lỗi yêu cầu',
      ServerFailure() => 'Lỗi máy chủ',
      _ => 'Đã xảy ra lỗi',
    };
  }
} 