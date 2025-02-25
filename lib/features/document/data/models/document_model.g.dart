// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentModelAdapter extends TypeAdapter<DocumentModel> {
  @override
  final int typeId = 13;

  @override
  DocumentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocumentModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      eventId: fields[2] as String?,
      title: fields[3] as String,
      filePath: fields[4] as String,
      documentType: fields[5] as DocumentTypeModel,
      uploadedAt: fields[6] as DateTime,
      metadata: (fields[7] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, DocumentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.eventId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.filePath)
      ..writeByte(5)
      ..write(obj.documentType)
      ..writeByte(6)
      ..write(obj.uploadedAt)
      ..writeByte(7)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentModelImpl _$$DocumentModelImplFromJson(Map<String, dynamic> json) =>
    _$DocumentModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      eventId: json['eventId'] as String?,
      title: json['title'] as String,
      filePath: json['filePath'] as String,
      documentType:
          $enumDecode(_$DocumentTypeModelEnumMap, json['documentType']),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DocumentModelImplToJson(_$DocumentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'eventId': instance.eventId,
      'title': instance.title,
      'filePath': instance.filePath,
      'documentType': instance.documentType,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$DocumentTypeModelEnumMap = {
  DocumentTypeModel.resume: 'resume',
  DocumentTypeModel.certificate: 'certificate',
  DocumentTypeModel.transcript: 'transcript',
  DocumentTypeModel.portfolio: 'portfolio',
  DocumentTypeModel.contract: 'contract',
  DocumentTypeModel.report: 'report',
  DocumentTypeModel.other: 'other',
};
