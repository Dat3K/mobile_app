import '../value_objects/user_role.dart';

abstract class UserEntity {
  String get id;
  String get email;
  UserRole get role;
  bool? get isActive;
  String? get avatarPath;
  DateTime? get lastLogin;
}
