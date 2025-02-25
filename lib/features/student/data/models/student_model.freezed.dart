// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  return _StudentModel.fromJson(json);
}

/// @nodoc
mixin _$StudentModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get fullName => throw _privateConstructorUsedError;
  @HiveField(3)
  String get major => throw _privateConstructorUsedError;
  @HiveField(4)
  int get graduationYear => throw _privateConstructorUsedError;
  @HiveField(5)
  int get enrollmentYear => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get skills => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get currentEnterpriseId => throw _privateConstructorUsedError;

  /// Serializes this StudentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentModelCopyWith<StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentModelCopyWith<$Res> {
  factory $StudentModelCopyWith(
          StudentModel value, $Res Function(StudentModel) then) =
      _$StudentModelCopyWithImpl<$Res, StudentModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String fullName,
      @HiveField(3) String major,
      @HiveField(4) int graduationYear,
      @HiveField(5) int enrollmentYear,
      @HiveField(6) List<String> skills,
      @HiveField(7) String? currentEnterpriseId});
}

/// @nodoc
class _$StudentModelCopyWithImpl<$Res, $Val extends StudentModel>
    implements $StudentModelCopyWith<$Res> {
  _$StudentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentModel
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
abstract class _$$StudentModelImplCopyWith<$Res>
    implements $StudentModelCopyWith<$Res> {
  factory _$$StudentModelImplCopyWith(
          _$StudentModelImpl value, $Res Function(_$StudentModelImpl) then) =
      __$$StudentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String userId,
      @HiveField(2) String fullName,
      @HiveField(3) String major,
      @HiveField(4) int graduationYear,
      @HiveField(5) int enrollmentYear,
      @HiveField(6) List<String> skills,
      @HiveField(7) String? currentEnterpriseId});
}

/// @nodoc
class __$$StudentModelImplCopyWithImpl<$Res>
    extends _$StudentModelCopyWithImpl<$Res, _$StudentModelImpl>
    implements _$$StudentModelImplCopyWith<$Res> {
  __$$StudentModelImplCopyWithImpl(
      _$StudentModelImpl _value, $Res Function(_$StudentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentModel
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
    return _then(_$StudentModelImpl(
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
@JsonSerializable()
class _$StudentModelImpl extends _StudentModel {
  const _$StudentModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.userId,
      @HiveField(2) required this.fullName,
      @HiveField(3) required this.major,
      @HiveField(4) required this.graduationYear,
      @HiveField(5) required this.enrollmentYear,
      @HiveField(6) required final List<String> skills,
      @HiveField(7) this.currentEnterpriseId})
      : _skills = skills,
        super._();

  factory _$StudentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String userId;
  @override
  @HiveField(2)
  final String fullName;
  @override
  @HiveField(3)
  final String major;
  @override
  @HiveField(4)
  final int graduationYear;
  @override
  @HiveField(5)
  final int enrollmentYear;
  final List<String> _skills;
  @override
  @HiveField(6)
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  @override
  @HiveField(7)
  final String? currentEnterpriseId;

  @override
  String toString() {
    return 'StudentModel(id: $id, userId: $userId, fullName: $fullName, major: $major, graduationYear: $graduationYear, enrollmentYear: $enrollmentYear, skills: $skills, currentEnterpriseId: $currentEnterpriseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of StudentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentModelImplCopyWith<_$StudentModelImpl> get copyWith =>
      __$$StudentModelImplCopyWithImpl<_$StudentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentModelImplToJson(
      this,
    );
  }
}

abstract class _StudentModel extends StudentModel {
  const factory _StudentModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String userId,
      @HiveField(2) required final String fullName,
      @HiveField(3) required final String major,
      @HiveField(4) required final int graduationYear,
      @HiveField(5) required final int enrollmentYear,
      @HiveField(6) required final List<String> skills,
      @HiveField(7) final String? currentEnterpriseId}) = _$StudentModelImpl;
  const _StudentModel._() : super._();

  factory _StudentModel.fromJson(Map<String, dynamic> json) =
      _$StudentModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get userId;
  @override
  @HiveField(2)
  String get fullName;
  @override
  @HiveField(3)
  String get major;
  @override
  @HiveField(4)
  int get graduationYear;
  @override
  @HiveField(5)
  int get enrollmentYear;
  @override
  @HiveField(6)
  List<String> get skills;
  @override
  @HiveField(7)
  String? get currentEnterpriseId;

  /// Create a copy of StudentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentModelImplCopyWith<_$StudentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
