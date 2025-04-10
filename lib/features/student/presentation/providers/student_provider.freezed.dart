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
  StudentEntity? get currentStudent => throw _privateConstructorUsedError;
  List<StudentEntity> get students => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  PaginatedResult<StudentEntity>? get paginatedStudents =>
      throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get hasMorePages => throw _privateConstructorUsedError;

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
      {StudentEntity? currentStudent,
      List<StudentEntity> students,
      bool isLoading,
      Failure? failure,
      PaginatedResult<StudentEntity>? paginatedStudents,
      int currentPage,
      int pageSize,
      bool hasMorePages});

  $StudentEntityCopyWith<$Res>? get currentStudent;
  $PaginatedResultCopyWith<StudentEntity, $Res>? get paginatedStudents;
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
    Object? currentStudent = freezed,
    Object? students = null,
    Object? isLoading = null,
    Object? failure = freezed,
    Object? paginatedStudents = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasMorePages = null,
  }) {
    return _then(_value.copyWith(
      currentStudent: freezed == currentStudent
          ? _value.currentStudent
          : currentStudent // ignore: cast_nullable_to_non_nullable
              as StudentEntity?,
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
      paginatedStudents: freezed == paginatedStudents
          ? _value.paginatedStudents
          : paginatedStudents // ignore: cast_nullable_to_non_nullable
              as PaginatedResult<StudentEntity>?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
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

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginatedResultCopyWith<StudentEntity, $Res>? get paginatedStudents {
    if (_value.paginatedStudents == null) {
      return null;
    }

    return $PaginatedResultCopyWith<StudentEntity, $Res>(
        _value.paginatedStudents!, (value) {
      return _then(_value.copyWith(paginatedStudents: value) as $Val);
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
      {StudentEntity? currentStudent,
      List<StudentEntity> students,
      bool isLoading,
      Failure? failure,
      PaginatedResult<StudentEntity>? paginatedStudents,
      int currentPage,
      int pageSize,
      bool hasMorePages});

  @override
  $StudentEntityCopyWith<$Res>? get currentStudent;
  @override
  $PaginatedResultCopyWith<StudentEntity, $Res>? get paginatedStudents;
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
    Object? currentStudent = freezed,
    Object? students = null,
    Object? isLoading = null,
    Object? failure = freezed,
    Object? paginatedStudents = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasMorePages = null,
  }) {
    return _then(_$StudentStateImpl(
      currentStudent: freezed == currentStudent
          ? _value.currentStudent
          : currentStudent // ignore: cast_nullable_to_non_nullable
              as StudentEntity?,
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
      paginatedStudents: freezed == paginatedStudents
          ? _value.paginatedStudents
          : paginatedStudents // ignore: cast_nullable_to_non_nullable
              as PaginatedResult<StudentEntity>?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StudentStateImpl extends _StudentState {
  const _$StudentStateImpl(
      {this.currentStudent,
      final List<StudentEntity> students = const [],
      this.isLoading = false,
      this.failure,
      this.paginatedStudents,
      this.currentPage = 1,
      this.pageSize = 10,
      this.hasMorePages = false})
      : _students = students,
        super._();

  @override
  final StudentEntity? currentStudent;
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
  final PaginatedResult<StudentEntity>? paginatedStudents;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final bool hasMorePages;

  @override
  String toString() {
    return 'StudentState(currentStudent: $currentStudent, students: $students, isLoading: $isLoading, failure: $failure, paginatedStudents: $paginatedStudents, currentPage: $currentPage, pageSize: $pageSize, hasMorePages: $hasMorePages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentStateImpl &&
            (identical(other.currentStudent, currentStudent) ||
                other.currentStudent == currentStudent) &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.paginatedStudents, paginatedStudents) ||
                other.paginatedStudents == paginatedStudents) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasMorePages, hasMorePages) ||
                other.hasMorePages == hasMorePages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStudent,
      const DeepCollectionEquality().hash(_students),
      isLoading,
      failure,
      paginatedStudents,
      currentPage,
      pageSize,
      hasMorePages);

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
      {final StudentEntity? currentStudent,
      final List<StudentEntity> students,
      final bool isLoading,
      final Failure? failure,
      final PaginatedResult<StudentEntity>? paginatedStudents,
      final int currentPage,
      final int pageSize,
      final bool hasMorePages}) = _$StudentStateImpl;
  const _StudentState._() : super._();

  @override
  StudentEntity? get currentStudent;
  @override
  List<StudentEntity> get students;
  @override
  bool get isLoading;
  @override
  Failure? get failure;
  @override
  PaginatedResult<StudentEntity>? get paginatedStudents;
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  bool get hasMorePages;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentStateImplCopyWith<_$StudentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
