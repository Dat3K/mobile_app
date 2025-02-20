import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/user_role.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required UserRole role,
    required bool isActive,
    required String avatarPath,
    required DateTime lastLogin,
  }) = _UserEntity;

  const UserEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    email.contains('@') &&
    avatarPath.isNotEmpty;

  // Business logic methods
  bool get canLogin => isActive;
  bool get hasValidSession => lastLogin.add(const Duration(days: 30)).isAfter(DateTime.now());
  bool hasRole(UserRole targetRole) => role == targetRole;
}
