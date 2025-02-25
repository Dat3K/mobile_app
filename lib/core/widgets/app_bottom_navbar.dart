import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/constants/route_paths.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';
import 'package:mobile_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Provider để quản lý trạng thái của bottom nav
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class AppBottomNavBar extends ConsumerWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy theme hiện tại
    final theme = ShadTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Lấy vai trò người dùng hiện tại
    final userRole = ref.watch(userRoleProvider);
    
    // Chọn tabs dựa theo vai trò
    final tabs = _getTabsForRole(userRole);

    // Tìm index hiện tại dựa trên path
    final currentIndex = tabs.indexWhere((tab) => currentPath.startsWith(tab.path));
    if (currentIndex >= 0) {
      // Cập nhật provider nếu index thay đổi
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(bottomNavIndexProvider.notifier).state = currentIndex;
      });
    }

    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isSelected = currentIndex == index;
              
              return _buildNavItem(
                context: context,
                tab: tab,
                isSelected: isSelected,
                onTap: () {
                  if (currentPath != tab.path) {
                    context.go(tab.path);
                    ref.read(bottomNavIndexProvider.notifier).state = index;
                  }
                },
                theme: theme,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Trả về danh sách các tab dựa trên vai trò
  List<NavItem> _getTabsForRole(UserRole? role) {
    if (role == null) {
      return _defaultTabs;
    }
    
    switch (role) {
      case UserRole.student:
        return _studentTabs;
      case UserRole.enterprise:
        return _enterpriseTabs;
      default:
        // Trường hợp chưa đăng nhập hoặc không xác định vai trò
        return _defaultTabs;
    }
  }

  /// Tab cho sinh viên
  List<NavItem> get _studentTabs => [
    NavItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      label: 'nav.explore'.tr(),
      path: RoutePaths.student,
    ),
    NavItem(
      icon: Icons.app_registration_outlined,
      activeIcon: Icons.app_registration,
      label: 'nav.register'.tr(),
      path: RoutePaths.studentRegister,
    ),
    NavItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'nav.notifications'.tr(),
      path: RoutePaths.studentNotifications,
      badgeCount: 2, // Thay thế bằng provider thực tế sau
    ),
    NavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'nav.profile'.tr(),
      path: RoutePaths.studentProfile,
    ),
  ];

  /// Tab cho doanh nghiệp
  List<NavItem> get _enterpriseTabs => [
    NavItem(
      icon: Icons.work_outline_rounded,
      activeIcon: Icons.work_rounded,
      label: 'nav.internships'.tr(),
      path: RoutePaths.enterprise,
    ),
    NavItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'nav.applicants'.tr(),
      path: RoutePaths.enterpriseApplicants,
    ),
    NavItem(
      icon: Icons.event_outlined,
      activeIcon: Icons.event_rounded,
      label: 'nav.events'.tr(),
      path: RoutePaths.enterpriseEvents,
    ),
    NavItem(
      icon: Icons.apartment_outlined,
      activeIcon: Icons.apartment_rounded,
      label: 'nav.profile'.tr(),
      path: RoutePaths.enterpriseProfile,
    ),
  ];

  /// Tab mặc định khi chưa đăng nhập
  List<NavItem> get _defaultTabs => [
    NavItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'nav.home'.tr(),
      path: RoutePaths.login,
    ),
  ];

  Widget _buildNavItem({
    required BuildContext context,
    required NavItem tab,
    required bool isSelected,
    required VoidCallback onTap,
    required ShadThemeData theme,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected 
                ? theme.colorScheme.primary.withValues(alpha: 0.1) 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isSelected ? tab.activeIcon : tab.icon,
                    color: isSelected 
                        ? theme.colorScheme.primary 
                        : theme.colorScheme.background.withValues(alpha: 0.7),
                    size: 24.sp,
                  ),
                  if (tab.badgeCount > 0)
                    Positioned(
                      right: -6.w,
                      top: -6.h,
                      child: Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.destructive,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          tab.badgeCount > 9 ? '9+' : tab.badgeCount.toString(),
                          style: TextStyle(
                            color: theme.colorScheme.destructiveForeground,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                tab.label,
                style: TextStyle(
                  color: isSelected 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.background.withValues(alpha: 0.7),
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String path;
  final int badgeCount;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.path,
    this.badgeCount = 0,
  });
} 