import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/utils/logger.dart';

// Auth Models
import 'package:mobile_app/features/auth/data/models/user_model.dart';
import 'package:mobile_app/features/auth/data/models/user_role_model.dart';

// Student Models
import 'package:mobile_app/features/student/data/models/student_model.dart';

// Enterprise Models
import 'package:mobile_app/features/enterprise/data/models/enterprise_model.dart';
import 'package:mobile_app/features/enterprise/data/models/enterprise_position_model.dart';

// Event Models
import 'package:mobile_app/features/event/data/models/event_model.dart';
import 'package:mobile_app/features/event/data/models/event_type_model.dart';
import 'package:mobile_app/features/event/data/models/event_status_model.dart';
import 'package:mobile_app/features/event/data/models/event_participation_model.dart';
import 'package:mobile_app/features/event/data/models/participation_role_model.dart';
import 'package:mobile_app/features/event/data/models/participation_status_model.dart';

// Notification Models
import 'package:mobile_app/features/notification/data/models/notification_model.dart';
import 'package:mobile_app/features/notification/data/models/notification_type_model.dart';

// Document Models
import 'package:mobile_app/features/document/data/models/document_model.dart';
import 'package:mobile_app/features/document/data/models/document_type_model.dart';

part 'hive_storage.g.dart';

/// Provider cho HiveStorageService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
HiveStorageService hiveStorageService(Ref ref) {
  final logger = ref.watch(loggerServiceProvider);
  return HiveStorageService(logger: logger);
}

abstract class IStorageService {
  Future<void> init();
  Future<void> clear();
  Future<T?> get<T>(String key, String boxName);
  Future<List<T>> getAll<T>(String boxName);
  Future<void> put<T>(String key, T value, String boxName);
  Future<void> putAll<T>(Map<String, T> entries, String boxName);
  Future<void> delete(String key, String boxName);
  Future<void> deleteAll(List<String> keys, String boxName);
  Future<void> clearBox(String boxName);
  Future<void> closeBox(String boxName);
  Future<void> dispose();
}

class HiveStorageService implements IStorageService {
  final ILoggerService _logger;
  final Map<String, Timer> _compactionTimers = {};
  final Map<String, Timer> _inactivityTimers = {};
  final Map<String, Box> _boxes = {};
  final Map<String, DateTime> _lastAccessTimes = {};

  HiveStorageService({
    required LoggerService logger,
  }) : _logger = logger;

  @override
  Future<void> init() async {
    try {
      // Initialize Hive if not already initialized
      await Hive.initFlutter();

      // Register adapters if not already registered
      _registerAdapters();

      _logger.i('Hive storage initialized successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to initialize Hive storage', e, stackTrace);
      throw CacheException('Failed to initialize Hive storage: $e');
    }
  }

  void _registerAdapters() {
    // Auth Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.user)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.userRole)) {
      Hive.registerAdapter(UserRoleModelAdapter());
    }

    // Student Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.student)) {
      Hive.registerAdapter(StudentModelAdapter());
    }

    // Enterprise Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.enterprise)) {
      Hive.registerAdapter(EnterpriseModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.enterprisePosition)) {
      Hive.registerAdapter(EnterprisePositionModelAdapter());
    }

    // Event Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.event)) {
      Hive.registerAdapter(EventModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.eventType)) {
      Hive.registerAdapter(EventTypeModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.eventStatus)) {
      Hive.registerAdapter(EventStatusModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.eventParticipation)) {
      Hive.registerAdapter(EventParticipationModelAdapter());
    }

    // Participation Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.participationRole)) {
      Hive.registerAdapter(ParticipationRoleModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.participationStatus)) {
      Hive.registerAdapter(ParticipationStatusModelAdapter());
    }

    // Notification Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.notification)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.notificationType)) {
      Hive.registerAdapter(NotificationTypeModelAdapter());
    }

    // Document Types
    if (!Hive.isAdapterRegistered(HiveTypeIds.document)) {
      Hive.registerAdapter(DocumentModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.documentType)) {
      Hive.registerAdapter(DocumentTypeModelAdapter());
    }
  }

  Future<Box<T>> _openBoxWithRetry<T>(
    String boxName, {
    int maxRetries = StorageKeys.maxRetryAttempts,
  }) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        if (Hive.isBoxOpen(boxName)) {
          final box = Hive.box(boxName);
          if (box is Box<T>) {
            _logger.d('Box $boxName is already open and of correct type');
            return box;
          }
          // Nếu box đã mở nhưng không đúng kiểu, đóng và mở lại
          _logger.d('Box $boxName is open but not of type ${T.toString()}, closing it');
          await box.close();
        }

        _logger.d('Opening box $boxName of type ${T.toString()}');

        // Thử mở box với các tham số cụ thể
        final box = await Hive.openBox<T>(
          boxName,
          compactionStrategy: (entries, deletedEntries) {
            return deletedEntries > 50 || deletedEntries > 0.1 * entries;
          },
        );

        _logger.d('Box $boxName opened successfully with ${box.length} entries');
        return box;
      } catch (e, stackTrace) {
        attempts++;
        _logger.w(
          'Failed to open box $boxName (attempt $attempts/$maxRetries): $e',
          e,
          stackTrace,
        );

        // Nếu lỗi là do box đã mở, thử đóng và mở lại
        if (e.toString().contains('already open')) {
          try {
            _logger.d('Box $boxName is already open, trying to close and reopen');
            if (Hive.isBoxOpen(boxName)) {
              await Hive.box(boxName).close();
            }
            continue; // Thử lại ngay lập tức
          } catch (closeError) {
            _logger.w('Failed to close box $boxName: $closeError');
          }
        }

        // Nếu lỗi là do box bị hỏng, thử xóa và tạo lại
        if (e.toString().contains('corrupted') || e.toString().contains('not found')) {
          try {
            _logger.d('Box $boxName is corrupted or not found, attempting recovery');
            await _recoverBox(boxName);
            continue; // Thử lại ngay lập tức
          } catch (recoverError) {
            _logger.w('Failed to recover box $boxName: $recoverError');
          }
        }

        if (attempts == maxRetries) {
          _logger.e('Max retries reached for box $boxName, attempting recovery');
          await _recoverBox(boxName);
          rethrow;
        }

        await Future.delayed(StorageKeys.retryDelay * attempts);
      }
    }
    throw CacheException('Failed to open box $boxName after $maxRetries attempts');
  }

  Future<void> _recoverBox(String boxName) async {
    try {
      // Đảm bảo box đã đóng trước khi xóa
      if (Hive.isBoxOpen(boxName)) {
        try {
          await Hive.box(boxName).close();
          _logger.d('Closed box $boxName before recovery');
        } catch (closeError) {
          _logger.w('Failed to close box $boxName before recovery: $closeError');
          // Tiếp tục với việc xóa dù không đóng được
        }
      }

      // Xóa box khỏi ổ đĩa
      await Hive.deleteBoxFromDisk(boxName);
      _logger.i('Deleted corrupted box: $boxName');

      // Xóa khỏi cache nếu có
      _boxes.remove(boxName);
      _compactionTimers[boxName]?.cancel();
      _compactionTimers.remove(boxName);
      _inactivityTimers[boxName]?.cancel();
      _inactivityTimers.remove(boxName);
      _lastAccessTimes.remove(boxName);
    } catch (e, stackTrace) {
      _logger.e('Failed to recover box $boxName: $e', e, stackTrace);
    }
  }

  void _setupCompactionTimer(String boxName) {
    _compactionTimers[boxName]?.cancel();
    _compactionTimers[boxName] = Timer.periodic(
      StorageKeys.compactionInterval,
      (_) async {
        try {
          final box = _boxes[boxName];
          if (box != null && !box.isOpen) return;
          await box?.compact();
          _logger.d('Compacted box: $boxName');
        } catch (e, stackTrace) {
          _logger.e('Failed to compact box $boxName', e, stackTrace);
        }
      },
    );
  }

  /// Thiết lập bộ hẹn giờ để đóng box sau một khoảng thời gian không hoạt động
  void _setupInactivityTimer(String boxName) {
    // Hủy bỏ bộ hẹn giờ cũ (nếu có)
    _inactivityTimers[boxName]?.cancel();

    // Thiết lập bộ hẹn giờ mới
    _inactivityTimers[boxName] = Timer(StorageKeys.inactivityTimeout, () async {
      try {
        // Kiểm tra xem box có tồn tại và đang mở không
        final box = _boxes[boxName];
        if (box == null || !box.isOpen) return;

        // Kiểm tra xem box có được sử dụng gần đây không
        final lastAccess = _lastAccessTimes[boxName];
        if (lastAccess == null) return;

        final timeSinceLastAccess = DateTime.now().difference(lastAccess);
        if (timeSinceLastAccess < StorageKeys.inactivityTimeout) {
          // Nếu box được sử dụng gần đây, thiết lập lại bộ hẹn giờ
          _setupInactivityTimer(boxName);
          return;
        }

        // Đóng box và xóa khỏi cache
        _logger.d('Closing box $boxName due to inactivity');
        await box.close();
        _boxes.remove(boxName);
        _compactionTimers[boxName]?.cancel();
        _compactionTimers.remove(boxName);
      } catch (e, stackTrace) {
        _logger.e('Failed to close inactive box $boxName', e, stackTrace);
      }
    });
  }

  Future<Box<T>> _getBox<T>(String boxName) async {
    try {
      // Cập nhật thời gian truy cập
      _lastAccessTimes[boxName] = DateTime.now();

      // Hủy bỏ bộ hẹn giờ không hoạt động hiện tại (nếu có)
      _inactivityTimers[boxName]?.cancel();

      // Kiểm tra xem box đã được mở và còn hợp lệ không
      if (_boxes.containsKey(boxName)) {
        final box = _boxes[boxName];
        if (box != null && box.isOpen) {
          if (box is Box<T>) {
            _logger.d('Using existing open box: $boxName');
            // Thiết lập bộ hẹn giờ không hoạt động mới
            _setupInactivityTimer(boxName);
            return box;
          }
          // Nếu box không đúng kiểu, đóng nó đi
          _logger.d('Box $boxName is open but not of type ${T.toString()}, closing it');
          await box.close();
          _boxes.remove(boxName);
        } else if (box != null) {
          _logger.d('Box $boxName is closed, removing from cache');
          _boxes.remove(boxName);
        }
      }

      // Kiểm tra xem box đã được mở trong Hive chưa
      if (Hive.isBoxOpen(boxName)) {
        final box = Hive.box(boxName);
        if (box is Box<T>) {
          _logger.d('Box $boxName is already open in Hive, using it');
          _boxes[boxName] = box;
          _setupCompactionTimer(boxName);
          _setupInactivityTimer(boxName);
          return box;
        } else {
          _logger.d('Box $boxName is open in Hive but not of type ${T.toString()}, closing it');
          await box.close();
        }
      }

      // Mở box mới với retry logic
      _logger.d('Opening box $boxName of type ${T.toString()}');
      final box = await _openBoxWithRetry<T>(boxName);
      _boxes[boxName] = box;

      // Set up compaction timer cho box mới
      _setupCompactionTimer(boxName);

      // Thiết lập bộ hẹn giờ không hoạt động
      _setupInactivityTimer(boxName);

      _logger.d('Box $boxName opened successfully');
      return box;
    } catch (e, stackTrace) {
      _logger.e('Failed to get box $boxName: $e', e, stackTrace);
      throw CacheException('Failed to get box $boxName: $e');
    }
  }

  @override
  Future<T?> get<T>(String key, String boxName) async {
    try {
      final box = await _getBox<T>(boxName);
      return box.get(key);
    } catch (e, stackTrace) {
      _logger.e('Failed to get data from box $boxName', e, stackTrace);
      throw CacheException('Failed to get data from Hive: $e');
    }
  }

  @override
  Future<List<T>> getAll<T>(String boxName) async {
    try {
      final box = await _getBox<T>(boxName);
      return box.values.cast<T>().toList();
    } catch (e, stackTrace) {
      _logger.e('Failed to get all data from box $boxName', e, stackTrace);
      throw CacheException('Failed to get all data from Hive: $e');
    }
  }

  @override
  Future<void> put<T>(String key, T value, String boxName) async {
    try {
      final box = await _getBox<T>(boxName);
      await box.put(key, value);
    } catch (e, stackTrace) {
      _logger.e('Failed to put data to box $boxName', e, stackTrace);
      throw CacheException('Failed to put data to Hive: $e');
    }
  }

  @override
  Future<void> putAll<T>(Map<String, T> entries, String boxName) async {
    try {
      final box = await _getBox<T>(boxName);
      await box.putAll(entries);
    } catch (e, stackTrace) {
      _logger.e('Failed to put all data to box $boxName', e, stackTrace);
      throw CacheException('Failed to put all data to Hive: $e');
    }
  }

  @override
  Future<void> delete(String key, String boxName) async {
    try {
      final box = await _getBox(boxName);
      await box.delete(key);
    } catch (e, stackTrace) {
      _logger.e('Failed to delete data from box $boxName', e, stackTrace);
      throw CacheException('Failed to delete data from Hive: $e');
    }
  }

  @override
  Future<void> deleteAll(List<String> keys, String boxName) async {
    try {
      final box = await _getBox(boxName);
      await box.deleteAll(keys);
    } catch (e, stackTrace) {
      _logger.e('Failed to delete all data from box $boxName', e, stackTrace);
      throw CacheException('Failed to delete all data from Hive: $e');
    }
  }

  @override
  Future<void> clearBox(String boxName) async {
    try {
      final box = await _getBox(boxName);
      await box.clear();
    } catch (e, stackTrace) {
      _logger.e('Failed to clear box $boxName', e, stackTrace);
      throw CacheException('Failed to clear Hive box: $e');
    }
  }

  @override
  Future<void> closeBox(String boxName) async {
    try {
      // Kiểm tra xem box có tồn tại và đang mở không
      if (_boxes.containsKey(boxName)) {
        final box = _boxes[boxName];
        if (box != null && box.isOpen) {
          _logger.d('Closing box $boxName manually');
          await box.close();
        }
        _boxes.remove(boxName);
      }

      // Hủy bỏ các bộ hẹn giờ
      _compactionTimers[boxName]?.cancel();
      _compactionTimers.remove(boxName);
      _inactivityTimers[boxName]?.cancel();
      _inactivityTimers.remove(boxName);
      _lastAccessTimes.remove(boxName);

      _logger.d('Box $boxName closed and removed from cache');
    } catch (e, stackTrace) {
      _logger.e('Failed to close box $boxName', e, stackTrace);
      throw CacheException('Failed to close Hive box: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      // Close all boxes first
      await Future.wait([
        for (final box in _boxes.values)
          if (box.isOpen) box.close(),
      ]);
      _boxes.clear();

      // Then delete from disk
      await Future.wait([
        for (final boxName in StorageKeys.allBoxes)
          Hive.deleteBoxFromDisk(boxName),
      ]);

      _logger.i('All Hive storage cleared successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to clear all Hive storage', e, stackTrace);
      throw CacheException('Failed to clear Hive storage: $e');
    }
  }

  @override
  Future<void> dispose() async {
    try {
      // Hủy bỏ tất cả các bộ hẹn giờ
      for (final timer in _compactionTimers.values) {
        timer.cancel();
      }
      _compactionTimers.clear();

      for (final timer in _inactivityTimers.values) {
        timer.cancel();
      }
      _inactivityTimers.clear();

      // Xóa tất cả các thời gian truy cập
      _lastAccessTimes.clear();

      // Đóng tất cả các box
      await Future.wait([
        for (final box in _boxes.values)
          if (box.isOpen) box.close(),
      ]);
      _boxes.clear();

      _logger.i('Hive storage disposed successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to dispose Hive storage', e, stackTrace);
      throw CacheException('Failed to dispose Hive storage: $e');
    }
  }
}

/// Extension cho debug
extension HiveStorageServiceDebugX on HiveStorageService {
  /// Clear tất cả storage (chỉ dùng trong debug)
  Future<void> debugClearAllStorage() async {
    try {
      _logger.w('🧹 Clearing all storage...');

      // 1. Clear all Hive boxes
      await clear();

      // 2. Delete all boxes from disk
      await Hive.deleteFromDisk();

      // 3. Re-initialize storage
      await init();

      _logger.i('✨ All storage cleared successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to clear storage during debug', e, stackTrace);
      rethrow;
    }
  }

  /// In ra trạng thái của tất cả boxes (chỉ dùng trong debug)
  Future<void> debugPrintBoxesStatus() async {
    try {
      _logger.w('🔍 Checking Hive storage status...');

      final buffer = StringBuffer();
      buffer.writeln('\n📦 Hive Storage Status Report');
      buffer.writeln('═════════════════════════\n');

      final totalBoxes = _boxes.length;
      final openBoxes = _boxes.values.where((box) => box.isOpen).length;
      final totalItems = _boxes.values
          .where((box) => box.isOpen)
          .fold(0, (sum, box) => sum + box.length);

      // Tổng quan
      buffer.writeln('📊 Overview:');
      buffer.writeln('  • Total Boxes: $totalBoxes');
      buffer.writeln('  • Open Boxes: $openBoxes');
      buffer.writeln('  • Total Items: $totalItems\n');

      // Chi tiết từng box
      if (totalBoxes > 0) {
        buffer.writeln('📋 Detailed Box Information:');
        buffer.writeln('──────────────────────────\n');

        for (final boxName in StorageKeys.allBoxes) {
          final box = _boxes[boxName];
          if (box != null) {
            final status = box.isOpen ? '🟢 Open' : '🔴 Closed';
            final itemCount = box.isOpen ? box.length : 'N/A';
            final lastAccess = _lastAccessTimes[boxName];
            final lastAccessStr = lastAccess != null
                ? '${DateTime.now().difference(lastAccess).inSeconds} seconds ago'
                : 'Never';

            buffer.writeln('📎 Box: $boxName');
            buffer.writeln('  • Status: $status');
            buffer.writeln('  • Items: $itemCount');
            buffer.writeln('  • Last Access: $lastAccessStr');

            if (box.isOpen && box.length > 0) {
              buffer.writeln('  • Content:');
              try {
                for (final key in box.keys) {
                  final value = box.get(key);
                  String displayValue;

                  if (value == null) {
                    displayValue = 'null';
                  } else if (value is Map || value is List) {
                    // Định dạng JSON cho Map và List
                    displayValue = value.toString().replaceAll(RegExp(r'\s+'), ' ');
                  } else {
                    displayValue = value.toString();
                  }

                  // Giới hạn độ dài của displayValue
                  if (displayValue.length > 100) {
                    displayValue = '${displayValue.substring(0, 97)}...';
                  }

                  buffer.writeln('    - $key: $displayValue');
                }
              } catch (e) {
                buffer.writeln('    ⚠️ Error reading box content: $e');
              }
            } else if (box.isOpen) {
              buffer.writeln('  • Content: Empty');
            }
            buffer.writeln(''); // Dòng trống giữa các box
          } else {
            buffer.writeln('📎 Box: $boxName');
            buffer.writeln('  • Status: ⚫ Not Initialized\n');
          }
        }
      } else {
        buffer.writeln('ℹ️ No boxes are initialized');
      }

      buffer.writeln('═════════════════════════');
      buffer.writeln('✨ Storage status check completed');

      // In tất cả thông tin một lần
      _logger.i(buffer.toString());
    } catch (e, stackTrace) {
      _logger.e('❌ Failed to check Hive storage status', e, stackTrace);
      rethrow;
    }
  }
}
