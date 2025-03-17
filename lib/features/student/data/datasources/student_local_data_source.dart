import 'package:mobile_app/core/constants/storage_keys.dart';
import 'package:mobile_app/core/storage/hive_storage.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:mobile_app/features/student/data/models/student_model.dart';

abstract class IStudentLocalDataSource {
  Future<void> saveStudent(StudentModel student);
  Future<StudentModel?> getStudent(String id);
  Future<StudentModel?> getStudentByUserId(String userId);
  Future<void> clearStudent(String id);
}

class StudentLocalDataSource implements IStudentLocalDataSource {
  final HiveStorageService _hiveStorage;
  final LoggerService _logger;

  StudentLocalDataSource({
    required HiveStorageService hiveStorage,
    required LoggerService logger,
  })  : _hiveStorage = hiveStorage,
        _logger = logger;

  @override
  Future<void> saveStudent(StudentModel student) async {
    await _hiveStorage.put<StudentModel>(StorageKeys.studentKey, student, StorageKeys.studentBox);
    _logger.i('Student saved to local storage');
  }

  @override
  Future<StudentModel?> getStudent(String id) async {
    final student = await _hiveStorage.get<StudentModel>(id, StorageKeys.studentBox);
    _logger.i('Student retrieved from local storage');
    return student;
  }

  @override
  Future<StudentModel?> getStudentByUserId(String userId) async {
    // Trong thực tế, bạn cần một cách để tìm kiếm student theo userId
    // Đây là một cách đơn giản, nhưng không hiệu quả cho dữ liệu lớn
    // Trong ứng dụng thực tế, bạn có thể cần một cấu trúc dữ liệu phức tạp hơn
    
    // Giả sử chúng ta có một key đặc biệt để lưu trữ mapping từ userId sang studentId
    final studentId = await _hiveStorage.get<String>(userId, StorageKeys.studentBox);
    if (studentId != null) {
      return getStudent(studentId);
    }
    return null;
  }

  @override
  Future<void> clearStudent(String id) async {
    await _hiveStorage.delete(id, StorageKeys.studentBox);
    _logger.i('Student deleted from local storage');
  }
}