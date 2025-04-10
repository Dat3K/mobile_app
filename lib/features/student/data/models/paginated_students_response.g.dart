// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_students_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedStudentsResponseImpl _$$PaginatedStudentsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginatedStudentsResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      hasPrevious: json['hasPrevious'] as bool,
    );

Map<String, dynamic> _$$PaginatedStudentsResponseImplToJson(
        _$PaginatedStudentsResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'pageSize': instance.pageSize,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
    };
