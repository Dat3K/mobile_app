import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../value_objects/user_role.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.user)
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required UserRole role,
    @HiveField(3) required bool isActive,
    @HiveField(4) required String avatarPath,
    @HiveField(5) required DateTime lastLogin,
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
