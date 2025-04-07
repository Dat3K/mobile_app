import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/error_handler.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/widgets/error_display.dart';

/// A widget that catches errors in its child tree and displays an error UI
class ErrorBoundary extends ConsumerStatefulWidget {
  final Widget child;
  final bool fullScreen;
  final VoidCallback? onRetry;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fullScreen = false,
    this.onRetry,
  });

  @override
  ConsumerState<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends ConsumerState<ErrorBoundary> {
  Failure? _error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // If we have a local error, show the error display
    if (_error != null) {
      return ErrorDisplay(
        failure: _error!,
        fullScreen: widget.fullScreen,
        onRetry: _handleRetry,
      );
    }

    // Otherwise, wrap the child with an error boundary
    return ErrorCatcher(
      onError: _handleError,
      child: widget.child,
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    // Convert errors to failures
    final failure = error is Failure 
        ? error 
        : ServerFailure('An unexpected error occurred: ${error.toString()}');
    
    // Report to global error handler
    ref.read(errorHandlerProvider.notifier).handleError(failure, stackTrace: stackTrace);
    
    // Set local error state
    setState(() {
      _error = failure;
    });
  }

  void _handleRetry() {
    // Clear local error
    setState(() {
      _error = null;
    });
    
    // Call onRetry if provided
    widget.onRetry?.call();
  }
}

/// A widget that catches errors in its child tree
class ErrorCatcher extends StatefulWidget {
  final Widget child;
  final void Function(Object error, StackTrace stackTrace) onError;

  const ErrorCatcher({
    super.key,
    required this.child,
    required this.onError,
  });

  @override
  State<ErrorCatcher> createState() => _ErrorCatcherState();
}

class _ErrorCatcherState extends State<ErrorCatcher> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        try {
          return widget.child;
        } catch (e, stackTrace) {
          widget.onError(e, stackTrace);
          return const SizedBox.shrink(); // Will be replaced by error UI
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    try {
      super.didChangeDependencies();
    } catch (e, stackTrace) {
      widget.onError(e, stackTrace);
    }
  }

  @override
  void didUpdateWidget(ErrorCatcher oldWidget) {
    try {
      super.didUpdateWidget(oldWidget);
    } catch (e, stackTrace) {
      widget.onError(e, stackTrace);
    }
  }
} 