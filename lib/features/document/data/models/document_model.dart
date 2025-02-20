import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/core/constants/hive_type_ids.dart';
import '../../domain/entities/document_entity.dart';
import 'document_type_model.dart';

part 'document_model.g.dart';
part 'document_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.document)
class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String? eventId,
    @HiveField(3) required String title,
    @HiveField(4) required String filePath,
    @HiveField(5) required DocumentTypeModel documentType,
    @HiveField(6) required DateTime uploadedAt,
    @HiveField(7) Map<String, dynamic>? metadata,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  const DocumentModel._();

  DocumentEntity toDomain() => DocumentEntity(
        id: id,
        userId: userId,
        eventId: eventId,
        title: title,
        filePath: filePath,
        documentType: documentType.toDomain(),
        uploadedAt: uploadedAt,
        metadata: metadata,
      );

  static DocumentModel fromDomain(DocumentEntity entity) => DocumentModel(
        id: entity.id,
        userId: entity.userId,
        eventId: entity.eventId,
        title: entity.title,
        filePath: entity.filePath,
        documentType: DocumentTypeModel.fromDomain(entity.documentType),
        uploadedAt: entity.uploadedAt,
        metadata: entity.metadata,
      );
} 