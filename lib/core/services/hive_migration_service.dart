import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/utils/logger.dart';

part 'hive_migration_service.g.dart';

/// Provider cho HiveMigrationService
@riverpod
HiveMigrationService hiveMigrationService(ref) {
  final logger = ref.watch(loggerServiceProvider);
  return HiveMigrationService(logger: logger);
}

class HiveMigrationService {
  final LoggerService _logger;

  HiveMigrationService({
    required LoggerService logger,
  }) : _logger = logger;

  /// Check and perform migrations if needed
  Future<void> checkAndMigrate(Box box) async {
    try {
      final version = box.get(StorageKeys.versionKey, defaultValue: 0) as int;
      
      if (version < StorageKeys.currentVersion) {
        await _performMigrations(box, version);
        await box.put(StorageKeys.versionKey, StorageKeys.currentVersion);
      }
    } catch (e, stackTrace) {
      _logger.e('Migration failed', e, stackTrace);
      throw CacheException('Failed to perform migration: $e');
    }
  }

  /// Perform migrations sequentially from the current version to the target version
  Future<void> _performMigrations(Box box, int fromVersion) async {
    for (var version = fromVersion + 1; 
         version <= StorageKeys.currentVersion; 
         version++) {
      await _migrateTo(box, version);
    }
  }

  /// Perform migration to a specific version
  Future<void> _migrateTo(Box box, int version) async {
    _logger.i('Migrating box ${box.name} to version $version');

    switch (version) {
      case 1:
        await _migrateToV1(box);
        break;
      // Add more cases for future versions
      default:
        _logger.w('No migration defined for version $version');
    }
  }

  /// Migration to version 1
  Future<void> _migrateToV1(Box box) async {
    try {
      // Example migration:
      // 1. Backup existing data
      final data = Map<dynamic, dynamic>.from(box.toMap());
      
      // 2. Clear the box
      await box.clear();
      
      // 3. Transform and reinsert data
      for (final entry in data.entries) {
        if (entry.value != null) {
          // Add your migration logic here
          await box.put(entry.key, entry.value);
        }
      }
      
      _logger.i('Successfully migrated ${box.name} to version 1');
    } catch (e, stackTrace) {
      _logger.e('Failed to migrate to version 1', e, stackTrace);
      throw CacheException('Migration to version 1 failed: $e');
    }
  }

  /// Validate box data after migration
  Future<bool> validateBox(Box box) async {
    try {
      // Add validation logic here
      return true;
    } catch (e, stackTrace) {
      _logger.e('Box validation failed', e, stackTrace);
      return false;
    }
  }

  /// Rollback migration if validation fails
  Future<void> rollback(Box box, Map<dynamic, dynamic> backup) async {
    try {
      await box.clear();
      await box.putAll(backup);
      _logger.i('Successfully rolled back migration for ${box.name}');
    } catch (e, stackTrace) {
      _logger.e('Rollback failed', e, stackTrace);
      throw CacheException('Failed to rollback migration: $e');
    }
  }
} 