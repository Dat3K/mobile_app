import 'dart:async';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
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

import '../services/encryption_service.dart';
import '../services/hive_migration_service.dart';

part 'hive_storage.g.dart';

/// Provider cho HiveStorageService - giữ instance trong suốt vòng đời ứng dụng
@Riverpod(keepAlive: true)
HiveStorageService hiveStorageService(ref) {
  final logger = ref.watch(loggerServiceProvider);
  final encryption = ref.watch(encryptionServiceProvider);
  final migration = ref.watch(hiveMigrationServiceProvider);
  return HiveStorageService(
    logger: logger,
    encryption: encryption,
    migration: migration,
  );
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
  Future<void> dispose();
}

class HiveStorageService implements IStorageService {
  final LoggerService _logger;
  final EncryptionService _encryption;
  final HiveMigrationService _migration;
  final Map<String, Timer> _compactionTimers = {};
  final Map<String, Box> _boxes = {};

  HiveStorageService({
    required LoggerService logger,
    required EncryptionService encryption,
    required HiveMigrationService migration,
  })  : _logger = logger,
        _encryption = encryption,
        _migration = migration;

  @override
  Future<void> init() async {
    try {
      // Initialize Hive if not already initialized
      await Hive.initFlutter();

      // Register adapters if not already registered
      _registerAdapters();

      // Get encryption key for secure boxes
      final encryptionKey = await _encryption.getEncryptionKey();

      // Open all boxes
      await Future.wait(
        StorageKeys.allBoxes.map((boxName) async {
          final isSecure = StorageKeys.secureBoxes.contains(boxName);
          final box = await _openBoxWithRetry<dynamic>(
            boxName,
            encryptionKey: isSecure ? encryptionKey : null,
          );
          _boxes[boxName] = box;

          // Set up compaction timer
          _setupCompactionTimer(boxName);

          // Check and perform migrations
          await _migration.checkAndMigrate(box);
        }),
      );

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
    Uint8List? encryptionKey,
    int maxRetries = StorageKeys.maxRetryAttempts,
  }) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        if (Hive.isBoxOpen(boxName)) {
          final box = Hive.box(boxName);
          if (box is Box<T>) {
            return box;
          }
          // Nếu box đã mở nhưng không đúng kiểu, đóng và mở lại
          await box.close();
        }
        return await Hive.openBox<T>(
          boxName,
          encryptionCipher:
              encryptionKey != null ? HiveAesCipher(encryptionKey) : null,
        );
      } catch (e, stackTrace) {
        attempts++;
        _logger.w(
          'Failed to open box $boxName (attempt $attempts/$maxRetries)',
          e,
          stackTrace,
        );
        if (attempts == maxRetries) {
          await _recoverBox(boxName);
          rethrow;
        }
        await Future.delayed(StorageKeys.retryDelay * attempts);
      }
    }
    throw CacheException('Failed to open box after $maxRetries attempts');
  }

  Future<void> _recoverBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
      _logger.i('Deleted corrupted box: $boxName');
    } catch (e, stackTrace) {
      _logger.e('Failed to recover box $boxName', e, stackTrace);
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

  Future<Box<T>> _getBox<T>(String boxName) async {
    try {
      if (!_boxes.containsKey(boxName) || !_boxes[boxName]!.isOpen) {
        _boxes[boxName] = await _openBoxWithRetry<T>(boxName);
      }

      final box = _boxes[boxName];
      if (box is Box<T>) {
        return box;
      }

      // Nếu box không đúng kiểu, đóng và mở lại với kiểu đúng
      if (box != null) {
        await box.close();
      }
      _boxes[boxName] = await _openBoxWithRetry<T>(boxName);
      return _boxes[boxName] as Box<T>;
    } catch (e, stackTrace) {
      _logger.e('Failed to get box $boxName', e, stackTrace);
      rethrow;
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
      // Cancel all compaction timers
      for (final timer in _compactionTimers.values) {
        timer.cancel();
      }
      _compactionTimers.clear();

      // Close all boxes
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
  void debugPrintBoxesStatus() {
    try {
      _logger.w('🧹 Checking Hive storage status...');
      
      final buffer = StringBuffer();
      buffer.writeln('\n📦 Hive Storage Status:');
      
      final totalBoxes = _boxes.length;
      buffer.writeln('Total boxes: $totalBoxes');
      
      if (totalBoxes > 0) {
        buffer.writeln('\nBoxes status:');
        for (final boxName in StorageKeys.allBoxes) {
          final box = _boxes[boxName];
          if (box != null) {
            final status = box.isOpen ? 'open' : 'closed';
            final itemCount = box.isOpen ? box.length : 'N/A';
            buffer.writeln('  - $boxName: $status, $itemCount items');
          } else {
            buffer.writeln('  - $boxName: not initialized');
          }
        }
      } else {
        buffer.writeln('No boxes initialized');
      }
      
      buffer.writeln('\n✨ Hive storage status check completed');
      
      // In tất cả thông tin một lần
      _logger.i(buffer.toString());
    } catch (e, stackTrace) {
      _logger.e('Failed to check Hive storage status', e, stackTrace);
      rethrow;
    }
  }
}
