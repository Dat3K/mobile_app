// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_students_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginatedStudentsResponse _$PaginatedStudentsResponseFromJson(
    Map<String, dynamic> json) {
  return _PaginatedStudentsResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedStudentsResponse {
  /// List of students for the current page
  List<StudentModel> get items => throw _privateConstructorUsedError;

  /// Total number of students
  int get total => throw _privateConstructorUsedError;

  /// Current page index
  int get currentPage => throw _privateConstructorUsedError;

  /// Total number of pages
  int get totalPages => throw _privateConstructorUsedError;

  /// Number of students per page
  int get pageSize => throw _privateConstructorUsedError;

  /// Whether there is a next page
  bool get hasNext => throw _privateConstructorUsedError;

  /// Whether there is a previous page
  bool get hasPrevious => throw _privateConstructorUsedError;

  /// Serializes this PaginatedStudentsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedStudentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedStudentsResponseCopyWith<PaginatedStudentsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedStudentsResponseCopyWith<$Res> {
  factory $PaginatedStudentsResponseCopyWith(PaginatedStudentsResponse value,
          $Res Function(PaginatedStudentsResponse) then) =
      _$PaginatedStudentsResponseCopyWithImpl<$Res, PaginatedStudentsResponse>;
  @useResult
  $Res call(
      {List<StudentModel> items,
      int total,
      int currentPage,
      int totalPages,
      int pageSize,
      bool hasNext,
      bool hasPrevious});
}

/// @nodoc
class _$PaginatedStudentsResponseCopyWithImpl<$Res,
        $Val extends PaginatedStudentsResponse>
    implements $PaginatedStudentsResponseCopyWith<$Res> {
  _$PaginatedStudentsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedStudentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? hasNext = null,
    Object? hasPrevious = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StudentModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrevious: null == hasPrevious
          ? _value.hasPrevious
          : hasPrevious // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedStudentsResponseImplCopyWith<$Res>
    implements $PaginatedStudentsResponseCopyWith<$Res> {
  factory _$$PaginatedStudentsResponseImplCopyWith(
          _$PaginatedStudentsResponseImpl value,
          $Res Function(_$PaginatedStudentsResponseImpl) then) =
      __$$PaginatedStudentsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<StudentModel> items,
      int total,
      int currentPage,
      int totalPages,
      int pageSize,
      bool hasNext,
      bool hasPrevious});
}

/// @nodoc
class __$$PaginatedStudentsResponseImplCopyWithImpl<$Res>
    extends _$PaginatedStudentsResponseCopyWithImpl<$Res,
        _$PaginatedStudentsResponseImpl>
    implements _$$PaginatedStudentsResponseImplCopyWith<$Res> {
  __$$PaginatedStudentsResponseImplCopyWithImpl(
      _$PaginatedStudentsResponseImpl _value,
      $Res Function(_$PaginatedStudentsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedStudentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? hasNext = null,
    Object? hasPrevious = null,
  }) {
    return _then(_$PaginatedStudentsResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StudentModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrevious: null == hasPrevious
          ? _value.hasPrevious
          : hasPrevious // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedStudentsResponseImpl extends _PaginatedStudentsResponse {
  const _$PaginatedStudentsResponseImpl(
      {required final List<StudentModel> items,
      required this.total,
      required this.currentPage,
      required this.totalPages,
      required this.pageSize,
      required this.hasNext,
      required this.hasPrevious})
      : _items = items,
        super._();

  factory _$PaginatedStudentsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedStudentsResponseImplFromJson(json);

  /// List of students for the current page
  final List<StudentModel> _items;

  /// List of students for the current page
  @override
  List<StudentModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Total number of students
  @override
  final int total;

  /// Current page index
  @override
  final int currentPage;

  /// Total number of pages
  @override
  final int totalPages;

  /// Number of students per page
  @override
  final int pageSize;

  /// Whether there is a next page
  @override
  final bool hasNext;

  /// Whether there is a previous page
  @override
  final bool hasPrevious;

  @override
  String toString() {
    return 'PaginatedStudentsResponse(items: $items, total: $total, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, hasNext: $hasNext, hasPrevious: $hasPrevious)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedStudentsResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrevious, hasPrevious) ||
                other.hasPrevious == hasPrevious));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      total,
      currentPage,
      totalPages,
      pageSize,
      hasNext,
      hasPrevious);

  /// Create a copy of PaginatedStudentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedStudentsResponseImplCopyWith<_$PaginatedStudentsResponseImpl>
      get copyWith => __$$PaginatedStudentsResponseImplCopyWithImpl<
          _$PaginatedStudentsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedStudentsResponseImplToJson(
      this,
    );
  }
}

abstract class _PaginatedStudentsResponse extends PaginatedStudentsResponse {
  const factory _PaginatedStudentsResponse(
      {required final List<StudentModel> items,
      required final int total,
      required final int currentPage,
      required final int totalPages,
      required final int pageSize,
      required final bool hasNext,
      required final bool hasPrevious}) = _$PaginatedStudentsResponseImpl;
  const _PaginatedStudentsResponse._() : super._();

  factory _PaginatedStudentsResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedStudentsResponseImpl.fromJson;

  /// List of students for the current page
  @override
  List<StudentModel> get items;

  /// Total number of students
  @override
  int get total;

  /// Current page index
  @override
  int get currentPage;

  /// Total number of pages
  @override
  int get totalPages;

  /// Number of students per page
  @override
  int get pageSize;

  /// Whether there is a next page
  @override
  bool get hasNext;

  /// Whether there is a previous page
  @override
  bool get hasPrevious;

  /// Create a copy of PaginatedStudentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedStudentsResponseImplCopyWith<_$PaginatedStudentsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
