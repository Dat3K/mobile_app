import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import 'student_model.dart';

part 'student_model_hive.g.dart';

@HiveType(typeId: HiveTypeIds.student)
class StudentModelHive extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String userId;

  @HiveField(2)
  late String major;

  @HiveField(3)
  late int graduationYear;

  @HiveField(4)
  late int enrollmentYear;

  @HiveField(5)
  late List<String> skills;

  @HiveField(6)
  String? currentEnterpriseId;

  StudentModelHive();

  StudentModelHive.create({
    required this.id,
    required this.userId,
    required this.major,
    required this.graduationYear,
    required this.enrollmentYear,
    required this.skills,
    this.currentEnterpriseId,
  });

  // Convert to freezed model
  StudentModel toModel() => StudentModel(
        id: id,
        userId: userId,
        major: major,
        graduationYear: graduationYear,
        enrollmentYear: enrollmentYear,
        skills: skills,
        currentEnterpriseId: currentEnterpriseId,
      );

  // Create from freezed model
  static StudentModelHive fromModel(StudentModel model) {
    return StudentModelHive.create(
      id: model.id,
      userId: model.userId,
      major: model.major,
      graduationYear: model.graduationYear,
      enrollmentYear: model.enrollmentYear,
      skills: model.skills,
      currentEnterpriseId: model.currentEnterpriseId,
    );
  }
}
