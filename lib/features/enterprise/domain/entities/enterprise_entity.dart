import 'package:freezed_annotation/freezed_annotation.dart';

part 'enterprise_entity.freezed.dart';

@freezed
class EnterpriseEntity with _$EnterpriseEntity {
  const factory EnterpriseEntity({
    required String id,
    required String name,
    required String description,
    required String industry,
    required String imagePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EnterpriseEntity;

  const EnterpriseEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    name.isNotEmpty &&
    description.isNotEmpty &&
    industry.isNotEmpty &&
    imagePath.isNotEmpty;

  // Business logic methods
  bool get hasLogo => imagePath.isNotEmpty;
  bool get isNew => DateTime.now().difference(createdAt).inDays < 30;
  bool get wasRecentlyUpdated => DateTime.now().difference(updatedAt).inDays < 7;
} 