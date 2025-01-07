import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/value_objects/user_role.dart';
import 'user_role_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
@freezed
class UserModel with _$UserModel implements UserEntity {
  const UserModel._();  // Constructor needed for custom getters

  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required UserRoleModel roleModel,
    @HiveField(3) bool? isActive,
    @HiveField(4) String? avatarPath,
    @HiveField(5) DateTime? lastLogin,
  }) = _UserModel;

  // Implement UserEntity interface
  @override
  UserRole get role => roleModel.toDomain();

  // Create UserModel from domain entity
  factory UserModel.fromDomain(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      roleModel: UserRoleModel.fromDomain(entity.role),
      isActive: entity.isActive,
      avatarPath: entity.avatarPath,
      lastLogin: entity.lastLogin,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
