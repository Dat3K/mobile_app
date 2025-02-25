import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/widgets/app_bottom_navbar.dart';

/// Scaffold chung cho toàn ứng dụng, hiển thị bottom nav bar
class AppScaffold extends ConsumerWidget {
  final Widget child;
  final String currentPath;
  final bool showBottomNav;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.child,
    required this.currentPath,
    this.showBottomNav = true,
    this.appBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        bottom: false, // Vì đã có bottom navigation bar với SafeArea
        child: Column(
          children: [
            // Main content area - takes all available space
            Expanded(child: child),
            
            // Bottom Navigation Bar
            if (showBottomNav) AppBottomNavBar(currentPath: currentPath),
          ],
        ),
      ),
    );
  }
} 