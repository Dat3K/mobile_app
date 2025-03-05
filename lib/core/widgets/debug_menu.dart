import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';
import 'package:mobile_app/core/theme/app_theme.dart';

/// Widget menu debug - chỉ hiển thị trong chế độ debug
class DebugMenu extends ConsumerWidget {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(currentThemeModeProvider);
    
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Debug Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Theme Toggle Section
          ExpansionTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme Settings'),
            subtitle: Text('Current: ${_getThemeModeName(themeMode)}'),
            children: [
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text('Light Mode'),
                trailing: themeMode == ThemeMode.light ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  ref.read(themeConfigNotifierProvider.notifier).setThemeMode(ThemeMode.light);
                  _showThemeChangeSnackbar(context, 'Light');
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: themeMode == ThemeMode.dark ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  ref.read(themeConfigNotifierProvider.notifier).setThemeMode(ThemeMode.dark);
                  _showThemeChangeSnackbar(context, 'Dark');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_system_daydream),
                title: const Text('System Mode'),
                trailing: themeMode == ThemeMode.system ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  ref.read(themeConfigNotifierProvider.notifier).resetToSystem();
                  _showThemeChangeSnackbar(context, 'System');
                },
              ),
              // Quick toggle button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Toggle Theme'),
                  onPressed: () {
                    ref.read(themeConfigNotifierProvider.notifier).toggleTheme();
                    _showThemeChangeSnackbar(context, 'Toggled');
                  },
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: const Text('Clear All Storage'),
            subtitle: const Text('Xóa tất cả dữ liệu lưu trữ'),
            onTap: () async {
              try {
                // Clear Hive storage
                await ref.read(hiveStorageServiceProvider).debugClearAllStorage();
                
                // Clear secure storage
                await ref.read(secureStorageServiceProvider).deleteAll();
                
                // Clear cookies
                await ref.read(cookieServiceProvider).clearCookies();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✨ Đã xóa tất cả dữ liệu'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('❌ Lỗi: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Storage Status'),
            subtitle: const Text('Xem trạng thái lưu trữ'),
            onTap: () {
              ref.read(hiveStorageServiceProvider).debugPrintBoxesStatus();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('📦 Đã in trạng thái storage vào console'),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Secure Storage Status'),
            subtitle: const Text('Xem trạng thái secure storage'),
            onTap: () async {
              await ref.read(secureStorageServiceProvider).debugPrintStorageStatus();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🔐 Đã in trạng thái secure storage vào console'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
  
  String _getThemeModeName(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'System',
    };
  }
  
  void _showThemeChangeSnackbar(BuildContext context, String modeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎨 Theme mode changed to $modeName'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}