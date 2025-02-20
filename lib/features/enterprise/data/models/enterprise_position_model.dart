import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/enterprise_position.dart';

part 'enterprise_position_model.g.dart';

@HiveType(typeId: HiveTypeIds.enterprisePosition)
enum EnterprisePositionModel {
  @JsonValue('admin')
  @HiveField(0)
  admin,

  @JsonValue('manager')
  @HiveField(1)
  manager,

  @JsonValue('coordinator')
  @HiveField(2)
  coordinator,

  @JsonValue('staff')
  @HiveField(3)
  staff;

  // Convert to domain value object
  EnterprisePosition toDomain() {
    switch (this) {
      case EnterprisePositionModel.admin:
        return EnterprisePosition.admin;
      case EnterprisePositionModel.manager:
        return EnterprisePosition.manager;
      case EnterprisePositionModel.coordinator:
        return EnterprisePosition.coordinator;
      case EnterprisePositionModel.staff:
        return EnterprisePosition.staff;
    }
  }

  // Convert from domain value object
  static EnterprisePositionModel fromDomain(EnterprisePosition position) {
    return EnterprisePositionModel.values.firstWhere((e) => e.name == position.name);
  }

  // For API serialization
  String toJson() => name;
  
  static EnterprisePositionModel fromJson(String json) {
    return EnterprisePositionModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => EnterprisePositionModel.staff,
    );
  }
} 