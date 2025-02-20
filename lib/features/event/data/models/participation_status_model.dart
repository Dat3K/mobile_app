import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/participation_status.dart';

part 'participation_status_model.g.dart';

@HiveType(typeId: HiveTypeIds.participationStatus)
enum ParticipationStatusModel {
  @JsonValue('pending')
  @HiveField(0)
  pending,

  @JsonValue('approved')
  @HiveField(1)
  approved,

  @JsonValue('rejected')
  @HiveField(2)
  rejected,

  @JsonValue('waitlisted')
  @HiveField(3)
  waitlisted,

  @JsonValue('withdrawn')
  @HiveField(4)
  withdrawn;

  // Convert to domain value object
  ParticipationStatus toDomain() {
    switch (this) {
      case ParticipationStatusModel.pending:
        return ParticipationStatus.pending;
      case ParticipationStatusModel.approved:
        return ParticipationStatus.approved;
      case ParticipationStatusModel.rejected:
        return ParticipationStatus.rejected;
      case ParticipationStatusModel.waitlisted:
        return ParticipationStatus.waitlisted;
      case ParticipationStatusModel.withdrawn:
        return ParticipationStatus.withdrawn;
    }
  }

  // Convert from domain value object
  static ParticipationStatusModel fromDomain(ParticipationStatus status) {
    return ParticipationStatusModel.values.firstWhere((e) => e.name == status.name);
  }

  // For API serialization
  String toJson() => name;
  
  static ParticipationStatusModel fromJson(String json) {
    return ParticipationStatusModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => ParticipationStatusModel.pending,
    );
  }
} 