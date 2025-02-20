// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprise_position_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnterprisePositionModelAdapter
    extends TypeAdapter<EnterprisePositionModel> {
  @override
  final int typeId = 4;

  @override
  EnterprisePositionModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnterprisePositionModel.admin;
      case 1:
        return EnterprisePositionModel.manager;
      case 2:
        return EnterprisePositionModel.coordinator;
      case 3:
        return EnterprisePositionModel.staff;
      default:
        return EnterprisePositionModel.admin;
    }
  }

  @override
  void write(BinaryWriter writer, EnterprisePositionModel obj) {
    switch (obj) {
      case EnterprisePositionModel.admin:
        writer.writeByte(0);
        break;
      case EnterprisePositionModel.manager:
        writer.writeByte(1);
        break;
      case EnterprisePositionModel.coordinator:
        writer.writeByte(2);
        break;
      case EnterprisePositionModel.staff:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnterprisePositionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
