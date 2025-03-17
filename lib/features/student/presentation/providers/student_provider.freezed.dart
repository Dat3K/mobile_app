// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentState {
  List<StudentEntity> get students => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  StudentEntity? get currentStudent => throw _privateConstructorUsedError;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentStateCopyWith<StudentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentStateCopyWith<$Res> {
  factory $StudentStateCopyWith(
          StudentState value, $Res Function(StudentState) then) =
      _$StudentStateCopyWithImpl<$Res, StudentState>;
  @useResult
  $Res call(
      {List<StudentEntity> students,
      bool isLoading,
      Failure? failure,
      StudentEntity? currentStudent});

  $StudentEntityCopyWith<$Res>? get currentStudent;
}

/// @nodoc
class _$StudentStateCopyWithImpl<$Res, $Val extends StudentState>
    implements $StudentStateCopyWith<$Res> {
  _$StudentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
    Object? isLoading = null,
    Object? failure = freezed,
    Object? currentStudent = freezed,
  }) {
    return _then(_value.copyWith(
      students: null == students
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentEntity>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      currentStudent: freezed == currentStudent
          ? _value.currentStudent
          : currentStudent // ignore: cast_nullable_to_non_nullable
              as StudentEntity?,
    ) as $Val);
  }

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudentEntityCopyWith<$Res>? get currentStudent {
    if (_value.currentStudent == null) {
      return null;
    }

    return $StudentEntityCopyWith<$Res>(_value.currentStudent!, (value) {
      return _then(_value.copyWith(currentStudent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudentStateImplCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$$StudentStateImplCopyWith(
          _$StudentStateImpl value, $Res Function(_$StudentStateImpl) then) =
      __$$StudentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<StudentEntity> students,
      bool isLoading,
      Failure? failure,
      StudentEntity? currentStudent});

  @override
  $StudentEntityCopyWith<$Res>? get currentStudent;
}

/// @nodoc
class __$$StudentStateImplCopyWithImpl<$Res>
    extends _$StudentStateCopyWithImpl<$Res, _$StudentStateImpl>
    implements _$$StudentStateImplCopyWith<$Res> {
  __$$StudentStateImplCopyWithImpl(
      _$StudentStateImpl _value, $Res Function(_$StudentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
    Object? isLoading = null,
    Object? failure = freezed,
    Object? currentStudent = freezed,
  }) {
    return _then(_$StudentStateImpl(
      students: null == students
          ? _value._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentEntity>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      currentStudent: freezed == currentStudent
          ? _value.currentStudent
          : currentStudent // ignore: cast_nullable_to_non_nullable
              as StudentEntity?,
    ));
  }
}

/// @nodoc

class _$StudentStateImpl extends _StudentState {
  const _$StudentStateImpl(
      {final List<StudentEntity> students = const [],
      this.isLoading = false,
      this.failure,
      this.currentStudent})
      : _students = students,
        super._();

  final List<StudentEntity> _students;
  @override
  @JsonKey()
  List<StudentEntity> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Failure? failure;
  @override
  final StudentEntity? currentStudent;

  @override
  String toString() {
    return 'StudentState(students: $students, isLoading: $isLoading, failure: $failure, currentStudent: $currentStudent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentStateImpl &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.currentStudent, currentStudent) ||
                other.currentStudent == currentStudent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_students),
      isLoading,
      failure,
      currentStudent);

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentStateImplCopyWith<_$StudentStateImpl> get copyWith =>
      __$$StudentStateImplCopyWithImpl<_$StudentStateImpl>(this, _$identity);
}

abstract class _StudentState extends StudentState {
  const factory _StudentState(
      {final List<StudentEntity> students,
      final bool isLoading,
      final Failure? failure,
      final StudentEntity? currentStudent}) = _$StudentStateImpl;
  const _StudentState._() : super._();

  @override
  List<StudentEntity> get students;
  @override
  bool get isLoading;
  @override
  Failure? get failure;
  @override
  StudentEntity? get currentStudent;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentStateImplCopyWith<_$StudentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
