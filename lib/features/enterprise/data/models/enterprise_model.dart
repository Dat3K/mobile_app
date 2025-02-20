import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/enterprise_entity.dart';

part 'enterprise_model.g.dart';
part 'enterprise_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.enterprise)
class EnterpriseModel with _$EnterpriseModel {
  const factory EnterpriseModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) required String industry,
    @HiveField(4) required String imagePath,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) required DateTime updatedAt,
  }) = _EnterpriseModel;

  factory EnterpriseModel.fromJson(Map<String, dynamic> json) =>
      _$EnterpriseModelFromJson(json);

  const EnterpriseModel._();

  EnterpriseEntity toDomain() => EnterpriseEntity(
        id: id,
        name: name,
        description: description,
        industry: industry,
        imagePath: imagePath,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  static EnterpriseModel fromDomain(EnterpriseEntity entity) => EnterpriseModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        industry: entity.industry,
        imagePath: entity.imagePath,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
} 