import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/participation_role.dart';

part 'participation_role_model.g.dart';

@HiveType(typeId: HiveTypeIds.participationRole)
enum ParticipationRoleModel {
  @JsonValue('participant')
  @HiveField(0)
  participant,

  @JsonValue('organizer')
  @HiveField(1)
  organizer,

  @JsonValue('mentor')
  @HiveField(2)
  mentor,

  @JsonValue('judge')
  @HiveField(3)
  judge;

  // Convert to domain value object
  ParticipationRole toDomain() {
    switch (this) {
      case ParticipationRoleModel.participant:
        return ParticipationRole.participant;
      case ParticipationRoleModel.organizer:
        return ParticipationRole.organizer;
      case ParticipationRoleModel.mentor:
        return ParticipationRole.mentor;
      case ParticipationRoleModel.judge:
        return ParticipationRole.judge;
    }
  }

  // Convert from domain value object
  static ParticipationRoleModel fromDomain(ParticipationRole role) {
    return ParticipationRoleModel.values.firstWhere((e) => e.name == role.name);
  }

  // For API serialization
  String toJson() => name;
  
  static ParticipationRoleModel fromJson(String json) {
    return ParticipationRoleModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => ParticipationRoleModel.participant,
    );
  }
} 