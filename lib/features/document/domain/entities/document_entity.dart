import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/document_type.dart';

part 'document_entity.freezed.dart';

@freezed
class DocumentEntity with _$DocumentEntity {
  const factory DocumentEntity({
    required String id,
    required String userId,
    required String? eventId,
    required String title,
    required String filePath,
    required DocumentType documentType,
    required DateTime uploadedAt,
    Map<String, dynamic>? metadata,
  }) = _DocumentEntity;

  const DocumentEntity._();

  // Validation methods
  bool get isValid =>
    id.isNotEmpty &&
    userId.isNotEmpty &&
    title.isNotEmpty &&
    filePath.isNotEmpty;

  // Business logic methods
  bool get isRequired => documentType.isRequired;
  bool get isConfidential => documentType.isConfidential;
  List<String> get allowedFileTypes => documentType.allowedFileTypes;
  
  bool get isEventDocument => eventId != null;
  bool get isRecentlyUploaded => 
    DateTime.now().difference(uploadedAt).inDays < 7;
  
  bool hasValidFileType(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    return allowedFileTypes.any((type) => 
      type.toLowerCase().contains(extension));
  }
} 