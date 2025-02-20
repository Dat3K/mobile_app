import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/value_objects/document_type.dart';

part 'document_type_model.g.dart';

@HiveType(typeId: HiveTypeIds.documentType)
enum DocumentTypeModel {
  @JsonValue('resume')
  @HiveField(0)
  resume,

  @JsonValue('certificate')
  @HiveField(1)
  certificate,

  @JsonValue('transcript')
  @HiveField(2)
  transcript,

  @JsonValue('portfolio')
  @HiveField(3)
  portfolio,

  @JsonValue('contract')
  @HiveField(4)
  contract,

  @JsonValue('report')
  @HiveField(5)
  report,

  @JsonValue('other')
  @HiveField(6)
  other;

  // Convert to domain value object
  DocumentType toDomain() {
    switch (this) {
      case DocumentTypeModel.resume:
        return DocumentType.resume;
      case DocumentTypeModel.certificate:
        return DocumentType.certificate;
      case DocumentTypeModel.transcript:
        return DocumentType.transcript;
      case DocumentTypeModel.portfolio:
        return DocumentType.portfolio;
      case DocumentTypeModel.contract:
        return DocumentType.contract;
      case DocumentTypeModel.report:
        return DocumentType.report;
      case DocumentTypeModel.other:
        return DocumentType.other;
    }
  }

  // Convert from domain value object
  static DocumentTypeModel fromDomain(DocumentType type) {
    return DocumentTypeModel.values.firstWhere((e) => e.name == type.name);
  }

  // For API serialization
  String toJson() => name;
  
  static DocumentTypeModel fromJson(String json) {
    return DocumentTypeModel.values.firstWhere(
      (e) => e.name == json,
      orElse: () => DocumentTypeModel.other,
    );
  }
} 