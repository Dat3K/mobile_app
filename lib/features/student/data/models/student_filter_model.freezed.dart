// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentFilterModel _$StudentFilterModelFromJson(Map<String, dynamic> json) {
  return _StudentFilterModel.fromJson(json);
}

/// @nodoc
mixin _$StudentFilterModel {
  /// Filter by student ID
  String? get id => throw _privateConstructorUsedError;

  /// Filter by user ID
  String? get userId => throw _privateConstructorUsedError;

  /// Filter by major
  String? get major => throw _privateConstructorUsedError;

  /// Filter by graduation year
  int? get graduationYear => throw _privateConstructorUsedError;

  /// Filter by enrollment year
  int? get enrollmentYear => throw _privateConstructorUsedError;

  /// Filter by skills (contains any of the skills)
  List<String>? get skills => throw _privateConstructorUsedError;

  /// Filter by current enterprise ID
  String? get currentEnterpriseId => throw _privateConstructorUsedError;

  /// Filter by graduation status
  bool? get isGraduated => throw _privateConstructorUsedError;

  /// Search term to match against multiple fields
  String? get searchTerm => throw _privateConstructorUsedError;

  /// Serializes this StudentFilterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentFilterModelCopyWith<StudentFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentFilterModelCopyWith<$Res> {
  factory $StudentFilterModelCopyWith(
          StudentFilterModel value, $Res Function(StudentFilterModel) then) =
      _$StudentFilterModelCopyWithImpl<$Res, StudentFilterModel>;
  @useResult
  $Res call(
      {String? id,
      String? userId,
      String? major,
      int? graduationYear,
      int? enrollmentYear,
      List<String>? skills,
      String? currentEnterpriseId,
      bool? isGraduated,
      String? searchTerm});
}

/// @nodoc
class _$StudentFilterModelCopyWithImpl<$Res, $Val extends StudentFilterModel>
    implements $StudentFilterModelCopyWith<$Res> {
  _$StudentFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? major = freezed,
    Object? graduationYear = freezed,
    Object? enrollmentYear = freezed,
    Object? skills = freezed,
    Object? currentEnterpriseId = freezed,
    Object? isGraduated = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      graduationYear: freezed == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      enrollmentYear: freezed == enrollmentYear
          ? _value.enrollmentYear
          : enrollmentYear // ignore: cast_nullable_to_non_nullable
              as int?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentEnterpriseId: freezed == currentEnterpriseId
          ? _value.currentEnterpriseId
          : currentEnterpriseId // ignore: cast_nullable_to_non_nullable
              as String?,
      isGraduated: freezed == isGraduated
          ? _value.isGraduated
          : isGraduated // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchTerm: freezed == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentFilterModelImplCopyWith<$Res>
    implements $StudentFilterModelCopyWith<$Res> {
  factory _$$StudentFilterModelImplCopyWith(_$StudentFilterModelImpl value,
          $Res Function(_$StudentFilterModelImpl) then) =
      __$$StudentFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? userId,
      String? major,
      int? graduationYear,
      int? enrollmentYear,
      List<String>? skills,
      String? currentEnterpriseId,
      bool? isGraduated,
      String? searchTerm});
}

/// @nodoc
class __$$StudentFilterModelImplCopyWithImpl<$Res>
    extends _$StudentFilterModelCopyWithImpl<$Res, _$StudentFilterModelImpl>
    implements _$$StudentFilterModelImplCopyWith<$Res> {
  __$$StudentFilterModelImplCopyWithImpl(_$StudentFilterModelImpl _value,
      $Res Function(_$StudentFilterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? major = freezed,
    Object? graduationYear = freezed,
    Object? enrollmentYear = freezed,
    Object? skills = freezed,
    Object? currentEnterpriseId = freezed,
    Object? isGraduated = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_$StudentFilterModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      graduationYear: freezed == graduationYear
          ? _value.graduationYear
          : graduationYear // ignore: cast_nullable_to_non_nullable
              as int?,
      enrollmentYear: freezed == enrollmentYear
          ? _value.enrollmentYear
          : enrollmentYear // ignore: cast_nullable_to_non_nullable
              as int?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currentEnterpriseId: freezed == currentEnterpriseId
          ? _value.currentEnterpriseId
          : currentEnterpriseId // ignore: cast_nullable_to_non_nullable
              as String?,
      isGraduated: freezed == isGraduated
          ? _value.isGraduated
          : isGraduated // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchTerm: freezed == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentFilterModelImpl implements _StudentFilterModel {
  const _$StudentFilterModelImpl(
      {this.id,
      this.userId,
      this.major,
      this.graduationYear,
      this.enrollmentYear,
      final List<String>? skills,
      this.currentEnterpriseId,
      this.isGraduated,
      this.searchTerm})
      : _skills = skills;

  factory _$StudentFilterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentFilterModelImplFromJson(json);

  /// Filter by student ID
  @override
  final String? id;

  /// Filter by user ID
  @override
  final String? userId;

  /// Filter by major
  @override
  final String? major;

  /// Filter by graduation year
  @override
  final int? graduationYear;

  /// Filter by enrollment year
  @override
  final int? enrollmentYear;

  /// Filter by skills (contains any of the skills)
  final List<String>? _skills;

  /// Filter by skills (contains any of the skills)
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Filter by current enterprise ID
  @override
  final String? currentEnterpriseId;

  /// Filter by graduation status
  @override
  final bool? isGraduated;

  /// Search term to match against multiple fields
  @override
  final String? searchTerm;

  @override
  String toString() {
    return 'StudentFilterModel(id: $id, userId: $userId, major: $major, graduationYear: $graduationYear, enrollmentYear: $enrollmentYear, skills: $skills, currentEnterpriseId: $currentEnterpriseId, isGraduated: $isGraduated, searchTerm: $searchTerm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentFilterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.graduationYear, graduationYear) ||
                other.graduationYear == graduationYear) &&
            (identical(other.enrollmentYear, enrollmentYear) ||
                other.enrollmentYear == enrollmentYear) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.currentEnterpriseId, currentEnterpriseId) ||
                other.currentEnterpriseId == currentEnterpriseId) &&
            (identical(other.isGraduated, isGraduated) ||
                other.isGraduated == isGraduated) &&
            (identical(other.searchTerm, searchTerm) ||
                other.searchTerm == searchTerm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      major,
      graduationYear,
      enrollmentYear,
      const DeepCollectionEquality().hash(_skills),
      currentEnterpriseId,
      isGraduated,
      searchTerm);

  /// Create a copy of StudentFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentFilterModelImplCopyWith<_$StudentFilterModelImpl> get copyWith =>
      __$$StudentFilterModelImplCopyWithImpl<_$StudentFilterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentFilterModelImplToJson(
      this,
    );
  }
}

abstract class _StudentFilterModel implements StudentFilterModel {
  const factory _StudentFilterModel(
      {final String? id,
      final String? userId,
      final String? major,
      final int? graduationYear,
      final int? enrollmentYear,
      final List<String>? skills,
      final String? currentEnterpriseId,
      final bool? isGraduated,
      final String? searchTerm}) = _$StudentFilterModelImpl;

  factory _StudentFilterModel.fromJson(Map<String, dynamic> json) =
      _$StudentFilterModelImpl.fromJson;

  /// Filter by student ID
  @override
  String? get id;

  /// Filter by user ID
  @override
  String? get userId;

  /// Filter by major
  @override
  String? get major;

  /// Filter by graduation year
  @override
  int? get graduationYear;

  /// Filter by enrollment year
  @override
  int? get enrollmentYear;

  /// Filter by skills (contains any of the skills)
  @override
  List<String>? get skills;

  /// Filter by current enterprise ID
  @override
  String? get currentEnterpriseId;

  /// Filter by graduation status
  @override
  bool? get isGraduated;

  /// Search term to match against multiple fields
  @override
  String? get searchTerm;

  /// Create a copy of StudentFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentFilterModelImplCopyWith<_$StudentFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
