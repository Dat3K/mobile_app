import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import 'user_role_model.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.user)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required UserRoleModel role,
    @HiveField(3) required bool isActive,
    @HiveField(4) required String avatarPath,
    @HiveField(5) required DateTime lastLogin,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  UserEntity toDomain() => UserEntity(
        id: id,
        email: email,
        role: role.toDomain(),
        isActive: isActive,
        avatarPath: avatarPath,
        lastLogin: lastLogin,
      );

  static UserModel fromDomain(UserEntity entity) => UserModel(
        id: entity.id,
        email: entity.email,
        role: UserRoleModel.fromDomain(entity.role),
        isActive: entity.isActive,
        avatarPath: entity.avatarPath,
        lastLogin: entity.lastLogin,
      );
}
