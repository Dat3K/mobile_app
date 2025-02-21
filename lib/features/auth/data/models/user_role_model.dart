import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';

part 'user_role_model.g.dart';

@HiveType(typeId: HiveTypeIds.userRole)
enum UserRoleModel {
  @JsonValue('faculty')
  @HiveField(0)
  faculty,

  @JsonValue('student')
  @HiveField(1)
  student,

  @JsonValue('enterprise')
  @HiveField(2)
  enterprise;

  // Convert to domain value object
  UserRole toDomain() {
    switch (this) {
      case UserRoleModel.faculty:
        return UserRole.faculty;
      case UserRoleModel.student:
        return UserRole.student;
      case UserRoleModel.enterprise:
        return UserRole.enterprise;
    }
  }

  // Convert from domain value object
  static UserRoleModel fromDomain(UserRole role) {
    return UserRoleModel.values.firstWhere((e) => e.name == role.name);
  }

  // For API serialization
  String toJson() => name;
  
  static UserRoleModel fromJson(String json) {
    return UserRoleModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => UserRoleModel.student, // Default value
    );
  }
}
