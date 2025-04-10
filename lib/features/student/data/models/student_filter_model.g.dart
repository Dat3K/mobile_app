// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentFilterModelImpl _$$StudentFilterModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentFilterModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      major: json['major'] as String?,
      graduationYear: (json['graduationYear'] as num?)?.toInt(),
      enrollmentYear: (json['enrollmentYear'] as num?)?.toInt(),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      currentEnterpriseId: json['currentEnterpriseId'] as String?,
      isGraduated: json['isGraduated'] as bool?,
      searchTerm: json['searchTerm'] as String?,
    );

Map<String, dynamic> _$$StudentFilterModelImplToJson(
        _$StudentFilterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'major': instance.major,
      'graduationYear': instance.graduationYear,
      'enrollmentYear': instance.enrollmentYear,
      'skills': instance.skills,
      'currentEnterpriseId': instance.currentEnterpriseId,
      'isGraduated': instance.isGraduated,
      'searchTerm': instance.searchTerm,
    };
