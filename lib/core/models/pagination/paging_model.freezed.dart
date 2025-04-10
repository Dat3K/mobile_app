// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PagingModel _$PagingModelFromJson(Map<String, dynamic> json) {
  return _PagingModel.fromJson(json);
}

/// @nodoc
mixin _$PagingModel {
  /// Number of items to take per page
  int get take => throw _privateConstructorUsedError;

  /// Page index (1-based)
  int get index => throw _privateConstructorUsedError;

  /// Serializes this PagingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagingModelCopyWith<PagingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingModelCopyWith<$Res> {
  factory $PagingModelCopyWith(
          PagingModel value, $Res Function(PagingModel) then) =
      _$PagingModelCopyWithImpl<$Res, PagingModel>;
  @useResult
  $Res call({int take, int index});
}

/// @nodoc
class _$PagingModelCopyWithImpl<$Res, $Val extends PagingModel>
    implements $PagingModelCopyWith<$Res> {
  _$PagingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? take = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      take: null == take
          ? _value.take
          : take // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingModelImplCopyWith<$Res>
    implements $PagingModelCopyWith<$Res> {
  factory _$$PagingModelImplCopyWith(
          _$PagingModelImpl value, $Res Function(_$PagingModelImpl) then) =
      __$$PagingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int take, int index});
}

/// @nodoc
class __$$PagingModelImplCopyWithImpl<$Res>
    extends _$PagingModelCopyWithImpl<$Res, _$PagingModelImpl>
    implements _$$PagingModelImplCopyWith<$Res> {
  __$$PagingModelImplCopyWithImpl(
      _$PagingModelImpl _value, $Res Function(_$PagingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? take = null,
    Object? index = null,
  }) {
    return _then(_$PagingModelImpl(
      take: null == take
          ? _value.take
          : take // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagingModelImpl implements _PagingModel {
  const _$PagingModelImpl({this.take = 10, this.index = 1});

  factory _$PagingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagingModelImplFromJson(json);

  /// Number of items to take per page
  @override
  @JsonKey()
  final int take;

  /// Page index (1-based)
  @override
  @JsonKey()
  final int index;

  @override
  String toString() {
    return 'PagingModel(take: $take, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingModelImpl &&
            (identical(other.take, take) || other.take == take) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, take, index);

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingModelImplCopyWith<_$PagingModelImpl> get copyWith =>
      __$$PagingModelImplCopyWithImpl<_$PagingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagingModelImplToJson(
      this,
    );
  }
}

abstract class _PagingModel implements PagingModel {
  const factory _PagingModel({final int take, final int index}) =
      _$PagingModelImpl;

  factory _PagingModel.fromJson(Map<String, dynamic> json) =
      _$PagingModelImpl.fromJson;

  /// Number of items to take per page
  @override
  int get take;

  /// Page index (1-based)
  @override
  int get index;

  /// Create a copy of PagingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagingModelImplCopyWith<_$PagingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginatedResult<T> {
  /// List of items for the current page
  List<T> get items => throw _privateConstructorUsedError;

  /// Total number of items
  int get total => throw _privateConstructorUsedError;

  /// Current page index
  int get currentPage => throw _privateConstructorUsedError;

  /// Total number of pages
  int get totalPages => throw _privateConstructorUsedError;

  /// Number of items per page
  int get pageSize => throw _privateConstructorUsedError;

  /// Whether there is a next page
  bool get hasNext => throw _privateConstructorUsedError;

  /// Whether there is a previous page
  bool get hasPrevious => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResultCopyWith<T, PaginatedResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResultCopyWith<T, $Res> {
  factory $PaginatedResultCopyWith(
          PaginatedResult<T> value, $Res Function(PaginatedResult<T>) then) =
      _$PaginatedResultCopyWithImpl<T, $Res, PaginatedResult<T>>;
  @useResult
  $Res call(
      {List<T> items,
      int total,
      int currentPage,
      int totalPages,
      int pageSize,
      bool hasNext,
      bool hasPrevious});
}

/// @nodoc
class _$PaginatedResultCopyWithImpl<T, $Res, $Val extends PaginatedResult<T>>
    implements $PaginatedResultCopyWith<T, $Res> {
  _$PaginatedResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResult
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
              as List<T>,
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
abstract class _$$PaginatedResultImplCopyWith<T, $Res>
    implements $PaginatedResultCopyWith<T, $Res> {
  factory _$$PaginatedResultImplCopyWith(_$PaginatedResultImpl<T> value,
          $Res Function(_$PaginatedResultImpl<T>) then) =
      __$$PaginatedResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> items,
      int total,
      int currentPage,
      int totalPages,
      int pageSize,
      bool hasNext,
      bool hasPrevious});
}

/// @nodoc
class __$$PaginatedResultImplCopyWithImpl<T, $Res>
    extends _$PaginatedResultCopyWithImpl<T, $Res, _$PaginatedResultImpl<T>>
    implements _$$PaginatedResultImplCopyWith<T, $Res> {
  __$$PaginatedResultImplCopyWithImpl(_$PaginatedResultImpl<T> _value,
      $Res Function(_$PaginatedResultImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedResult
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
    return _then(_$PaginatedResultImpl<T>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
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

class _$PaginatedResultImpl<T> implements _PaginatedResult<T> {
  const _$PaginatedResultImpl(
      {required final List<T> items,
      required this.total,
      required this.currentPage,
      required this.totalPages,
      required this.pageSize,
      required this.hasNext,
      required this.hasPrevious})
      : _items = items;

  /// List of items for the current page
  final List<T> _items;

  /// List of items for the current page
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Total number of items
  @override
  final int total;

  /// Current page index
  @override
  final int currentPage;

  /// Total number of pages
  @override
  final int totalPages;

  /// Number of items per page
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
    return 'PaginatedResult<$T>(items: $items, total: $total, currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, hasNext: $hasNext, hasPrevious: $hasPrevious)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResultImpl<T> &&
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

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      __$$PaginatedResultImplCopyWithImpl<T, _$PaginatedResultImpl<T>>(
          this, _$identity);
}

abstract class _PaginatedResult<T> implements PaginatedResult<T> {
  const factory _PaginatedResult(
      {required final List<T> items,
      required final int total,
      required final int currentPage,
      required final int totalPages,
      required final int pageSize,
      required final bool hasNext,
      required final bool hasPrevious}) = _$PaginatedResultImpl<T>;

  /// List of items for the current page
  @override
  List<T> get items;

  /// Total number of items
  @override
  int get total;

  /// Current page index
  @override
  int get currentPage;

  /// Total number of pages
  @override
  int get totalPages;

  /// Number of items per page
  @override
  int get pageSize;

  /// Whether there is a next page
  @override
  bool get hasNext;

  /// Whether there is a previous page
  @override
  bool get hasPrevious;

  /// Create a copy of PaginatedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResultImplCopyWith<T, _$PaginatedResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
