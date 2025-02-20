// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentTypeModelAdapter extends TypeAdapter<DocumentTypeModel> {
  @override
  final int typeId = 13;

  @override
  DocumentTypeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DocumentTypeModel.resume;
      case 1:
        return DocumentTypeModel.certificate;
      case 2:
        return DocumentTypeModel.transcript;
      case 3:
        return DocumentTypeModel.portfolio;
      case 4:
        return DocumentTypeModel.contract;
      case 5:
        return DocumentTypeModel.report;
      case 6:
        return DocumentTypeModel.other;
      default:
        return DocumentTypeModel.resume;
    }
  }

  @override
  void write(BinaryWriter writer, DocumentTypeModel obj) {
    switch (obj) {
      case DocumentTypeModel.resume:
        writer.writeByte(0);
        break;
      case DocumentTypeModel.certificate:
        writer.writeByte(1);
        break;
      case DocumentTypeModel.transcript:
        writer.writeByte(2);
        break;
      case DocumentTypeModel.portfolio:
        writer.writeByte(3);
        break;
      case DocumentTypeModel.contract:
        writer.writeByte(4);
        break;
      case DocumentTypeModel.report:
        writer.writeByte(5);
        break;
      case DocumentTypeModel.other:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
