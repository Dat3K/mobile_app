import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/error/exceptions.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import '../models/student_model.dart';

abstract class IStudentLocalDataSource {
  /// Gets a student from local storage by ID
  Future<StudentModel?> getStudent(String id);

  /// Gets a student from local storage by user ID
  Future<StudentModel?> getStudentByUserId(String userId);

  /// Gets all students from local storage
  Future<List<StudentModel>> getAllStudents();

  /// Saves a student to local storage
  Future<void> saveStudent(StudentModel student);

  /// Deletes a student from local storage
  Future<void> deleteStudent(String id);

  /// Clears all students from local storage
  Future<void> clearStudents();
}

class StudentLocalDataSource implements IStudentLocalDataSource {
  final HiveStorageService _storage;
  final LoggerService _logger;

  StudentLocalDataSource({
    required HiveStorageService storage,
    required LoggerService logger,
  })  : _storage = storage,
        _logger = logger;

  @override
  Future<StudentModel?> getStudent(String id) async {
    try {
      final student = await _storage.get<StudentModel>(id, StorageKeys.studentBox);
      _logger.d('Retrieved student from local storage: $id');
      return student;
    } catch (e, stackTrace) {
      _logger.e('Error retrieving student from local storage', e, stackTrace);
      throw CacheException('Failed to get student from local storage: $e');
    }
  }

  @override
  Future<StudentModel?> getStudentByUserId(String userId) async {
    try {
      final students = await getAllStudents();
      final student = students.where((s) => s.userId == userId).firstOrNull;
      _logger.d('Retrieved student by userId from local storage: $userId');
      return student;
    } catch (e, stackTrace) {
      _logger.e('Error retrieving student by userId from local storage', e, stackTrace);
      throw CacheException('Failed to get student by userId from local storage: $e');
    }
  }

  @override
  Future<List<StudentModel>> getAllStudents() async {
    try {
      final students = await _storage.getAll<StudentModel>(StorageKeys.studentBox);
      _logger.d('Retrieved all students from local storage: ${students.length} students');
      return students;
    } catch (e, stackTrace) {
      _logger.e('Error retrieving all students from local storage', e, stackTrace);
      throw CacheException('Failed to get all students from local storage: $e');
    }
  }

  @override
  Future<void> saveStudent(StudentModel student) async {
    try {
      await _storage.put<StudentModel>(student.id, student, StorageKeys.studentBox);
      _logger.d('Saved student to local storage: ${student.id}');
    } catch (e, stackTrace) {
      _logger.e('Error saving student to local storage', e, stackTrace);
      throw CacheException('Failed to save student to local storage: $e');
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    try {
      await _storage.delete(id, StorageKeys.studentBox);
      _logger.d('Deleted student from local storage: $id');
    } catch (e, stackTrace) {
      _logger.e('Error deleting student from local storage', e, stackTrace);
      throw CacheException('Failed to delete student from local storage: $e');
    }
  }

  @override
  Future<void> clearStudents() async {
    try {
      await _storage.clearBox(StorageKeys.studentBox);
      _logger.d('Cleared all students from local storage');
    } catch (e, stackTrace) {
      _logger.e('Error clearing students from local storage', e, stackTrace);
      throw CacheException('Failed to clear students from local storage: $e');
    }
  }
}