import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:easy_localization/easy_localization.dart';

/// A widget to display errors in a consistent manner across the app
class ErrorDisplay extends ConsumerWidget {
  final Failure failure;
  final VoidCallback? onRetry;
  final bool showRetry;
  final bool fullScreen;

  const ErrorDisplay({
    super.key,
    required this.failure,
    this.onRetry,
    this.showRetry = true,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    
    // Get the error icon and color based on failure type
    final (IconData icon, Color color) = _getErrorIconAndColor(failure, context);
    
    // Build the error content
    Widget errorContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: fullScreen ? 72.sp : 48.sp,
        ),
        SizedBox(height: 16.h),
        ShadCard(
          title: Text(
            _getErrorTitle(failure),
            style: TextStyle(
              color: theme.colorScheme.destructive,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: failure.message,
                  style: TextStyle(
                    color: theme.colorScheme.destructive,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          child: Column(
            children: [
              if (showRetry && onRetry != null) ...[
                SizedBox(height: 16.h),
                ShadButton.destructive(
                  onPressed: () {
                    onRetry?.call();
                    if (!fullScreen) {
                      ShadToaster.of(context).hide();
                    }
                  },
                  leading: Icon(Icons.refresh, size: 18.sp),
                  child: Text('common.retry'.tr()),
                ),
              ],
            ],
          ),
        ),
      ],
    );

    // If it's a full screen error, center it on the screen
    if (fullScreen) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.sp),
            child: errorContent,
          ),
        ),
      );
    }

    // For inline errors, show as a toast
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShadToaster.of(context).show(
        ShadToast.destructive(
          title: Text(_getErrorTitle(failure)),
          description: Text(failure.message),
          action: showRetry && onRetry != null
              ? ShadButton.destructive(
                  decoration: ShadDecoration(
                    border: ShadBorder.all(
                      color: theme.colorScheme.destructiveForeground,
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    onRetry?.call();
                    ShadToaster.of(context).hide();
                  },
                  child: Text('common.retry'.tr()),
                )
              : null,
        ),
      );
    });

    // Return an empty container for inline errors since we're using toast
    return const SizedBox.shrink();
  }

  // Helper method to get appropriate icon and color based on failure type
  (IconData, Color) _getErrorIconAndColor(Failure failure, BuildContext context) {
    final theme = ShadTheme.of(context);
    return switch (failure) {
      ConnectionFailure() => (Icons.signal_wifi_off, theme.colorScheme.muted),
      ServerFailure() => (Icons.cloud_off, theme.colorScheme.destructive),
      AuthFailure() => (Icons.lock, theme.colorScheme.destructive),
      ValidationFailure() => (Icons.warning, theme.colorScheme.muted),
      _ => (Icons.error_outline, theme.colorScheme.destructive),
    };
  }

  // Helper method to get the error title based on failure type
  String _getErrorTitle(Failure failure) {
    return switch (failure) {
      ConnectionFailure() => 'error.connection_error'.tr(),
      ServerFailure() => 'error.server_error'.tr(),
      AuthFailure() => 'error.auth_error'.tr(),
      ValidationFailure() => 'error.validation_error'.tr(),
      _ => 'error.general_error'.tr(),
    };
  }
}

/// A widget to display a fullscreen error state
class FullscreenErrorDisplay extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;

  const FullscreenErrorDisplay({
    super.key,
    required this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorDisplay(
      failure: failure,
      onRetry: onRetry,
      fullScreen: true,
    );
  }
}

/// A widget to display an inline error state within a page
class InlineErrorDisplay extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;

  const InlineErrorDisplay({
    super.key,
    required this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorDisplay(
      failure: failure,
      onRetry: onRetry,
      fullScreen: false,
    );
  }
} 