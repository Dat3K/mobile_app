import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';

part 'user_role.g.dart';

@HiveType(typeId: HiveTypeIds.userRole)
enum UserRole {
  @HiveField(0)
  faculty,

  @HiveField(1)
  student,

  @HiveField(2)
  enterprise;

  String get displayName {
    switch (this) {
      case UserRole.faculty:
        return 'Faculty';
      case UserRole.student:
        return 'Student';
      case UserRole.enterprise:
        return 'Enterprise';
    }
  }

  bool get isFaculty => this == UserRole.faculty;
  bool get isStudent => this == UserRole.student;
  bool get isEnterprise => this == UserRole.enterprise;
}
