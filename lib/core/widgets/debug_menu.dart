import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/services/cookie_service.dart';
import 'package:mobile_app/core/storage/secure_storage.dart';

/// Widget menu debug - chỉ hiển thị trong chế độ debug
class DebugMenu extends ConsumerWidget {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
} 