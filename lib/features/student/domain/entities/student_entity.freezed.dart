// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  int get graduationYear => throw _privateConstructorUsedError;
  int get enrollmentYear => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  String? get currentEnterpriseId => throw _privateConstructorUsedError;

  /// Create a copy of StudentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentEntityCopyWith<StudentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentEntityCopyWith<$Res> {
  factory $StudentEntityCopyWith(
          StudentEntity value, $Res Function(StudentEntity) then) =
      _$StudentEntityCopyWithImpl<$Res, StudentEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String major,
      int graduationYear,
      int enrollmentYear,
      List<String> skills,
      String? currentEnterpriseId});
}

/// @nodoc
class _$StudentEntityCopyWithImpl<$Res, $Val extends StudentEntity>
    implements $StudentEntityCopyWith<$Res> {
  _$StudentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? major = null,
    Object? graduationYear = null,
    Object? enrollmentYear = null,
    Object? skills = null,
    Object? currentEnterpriseId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      graduationYear: null == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int,
      enrollmentYear: null == enrollmentYear
          ? _value.enrollmentYear
          : enrollmentYear // ignore: cast_nullable_to_non_nullable
              as int,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentEnterpriseId: freezed == currentEnterpriseId
          ? _value.currentEnterpriseId
          : currentEnterpriseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentEntityImplCopyWith<$Res>
    implements $StudentEntityCopyWith<$Res> {
  factory _$$StudentEntityImplCopyWith(
          _$StudentEntityImpl value, $Res Function(_$StudentEntityImpl) then) =
      __$$StudentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String major,
      int graduationYear,
      int enrollmentYear,
      List<String> skills,
      String? currentEnterpriseId});
}

/// @nodoc
class __$$StudentEntityImplCopyWithImpl<$Res>
    extends _$StudentEntityCopyWithImpl<$Res, _$StudentEntityImpl>
    implements _$$StudentEntityImplCopyWith<$Res> {
  __$$StudentEntityImplCopyWithImpl(
      _$StudentEntityImpl _value, $Res Function(_$StudentEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? major = null,
    Object? graduationYear = null,
    Object? enrollmentYear = null,
    Object? skills = null,
    Object? currentEnterpriseId = freezed,
  }) {
    return _then(_$StudentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      graduationYear: null == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int,
      enrollmentYear: null == enrollmentYear
          ? _value.enrollmentYear
          : enrollmentYear // ignore: cast_nullable_to_non_nullable
              as int,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentEnterpriseId: freezed == currentEnterpriseId
          ? _value.currentEnterpriseId
          : currentEnterpriseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StudentEntityImpl extends _StudentEntity {
  const _$StudentEntityImpl(
      {required this.id,
      required this.userId,
      required this.fullName,
      required this.major,
      required this.graduationYear,
      required this.enrollmentYear,
      required final List<String> skills,
      this.currentEnterpriseId})
      : _skills = skills,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String fullName;
  @override
  final String major;
  @override
  final int graduationYear;
  @override
  final int enrollmentYear;
  final List<String> _skills;
  @override
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  @override
  final String? currentEnterpriseId;

  @override
  String toString() {
    return 'StudentEntity(id: $id, userId: $userId, fullName: $fullName, major: $major, graduationYear: $graduationYear, enrollmentYear: $enrollmentYear, skills: $skills, currentEnterpriseId: $currentEnterpriseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.graduationYear, graduationYear) ||
                other.graduationYear == graduationYear) &&
            (identical(other.enrollmentYear, enrollmentYear) ||
                other.enrollmentYear == enrollmentYear) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.currentEnterpriseId, currentEnterpriseId) ||
                other.currentEnterpriseId == currentEnterpriseId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      fullName,
      major,
      graduationYear,
      enrollmentYear,
      const DeepCollectionEquality().hash(_skills),
      currentEnterpriseId);

  /// Create a copy of StudentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentEntityImplCopyWith<_$StudentEntityImpl> get copyWith =>
      __$$StudentEntityImplCopyWithImpl<_$StudentEntityImpl>(this, _$identity);
}

abstract class _StudentEntity extends StudentEntity {
  const factory _StudentEntity(
      {required final String id,
      required final String userId,
      required final String fullName,
      required final String major,
      required final int graduationYear,
      required final int enrollmentYear,
      required final List<String> skills,
      final String? currentEnterpriseId}) = _$StudentEntityImpl;
  const _StudentEntity._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get fullName;
  @override
  String get major;
  @override
  int get graduationYear;
  @override
  int get enrollmentYear;
  @override
  List<String> get skills;
  @override
  String? get currentEnterpriseId;

  /// Create a copy of StudentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentEntityImplCopyWith<_$StudentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
