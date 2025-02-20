import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/value_objects/user_role.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.user)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String role,
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
        role: UserRole.values.firstWhere(
          (role) => role.name.toLowerCase() == this.role.toLowerCase(),
          orElse: () => UserRole.student,
        ),
        isActive: isActive,
        avatarPath: avatarPath,
        lastLogin: lastLogin,
      );
}
