// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagingModelImpl _$$PagingModelImplFromJson(Map<String, dynamic> json) =>
    _$PagingModelImpl(
      take: (json['take'] as num?)?.toInt() ?? 10,
      index: (json['index'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$PagingModelImplToJson(_$PagingModelImpl instance) =>
    <String, dynamic>{
      'take': instance.take,
      'index': instance.index,
    };
