// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DocumentEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DocumentType get documentType => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Create a copy of DocumentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentEntityCopyWith<DocumentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentEntityCopyWith<$Res> {
  factory $DocumentEntityCopyWith(
          DocumentEntity value, $Res Function(DocumentEntity) then) =
      _$DocumentEntityCopyWithImpl<$Res, DocumentEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? eventId,
      String title,
      String filePath,
      DocumentType documentType,
      DateTime uploadedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$DocumentEntityCopyWithImpl<$Res, $Val extends DocumentEntity>
    implements $DocumentEntityCopyWith<$Res> {
  _$DocumentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventId = freezed,
    Object? title = null,
    Object? filePath = null,
    Object? documentType = null,
    Object? uploadedAt = null,
    Object? metadata = freezed,
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
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentEntityImplCopyWith<$Res>
    implements $DocumentEntityCopyWith<$Res> {
  factory _$$DocumentEntityImplCopyWith(_$DocumentEntityImpl value,
          $Res Function(_$DocumentEntityImpl) then) =
      __$$DocumentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? eventId,
      String title,
      String filePath,
      DocumentType documentType,
      DateTime uploadedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$DocumentEntityImplCopyWithImpl<$Res>
    extends _$DocumentEntityCopyWithImpl<$Res, _$DocumentEntityImpl>
    implements _$$DocumentEntityImplCopyWith<$Res> {
  __$$DocumentEntityImplCopyWithImpl(
      _$DocumentEntityImpl _value, $Res Function(_$DocumentEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventId = freezed,
    Object? title = null,
    Object? filePath = null,
    Object? documentType = null,
    Object? uploadedAt = null,
    Object? metadata = freezed,
  }) {
    return _then(_$DocumentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      documentType: null == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as DocumentType,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$DocumentEntityImpl extends _DocumentEntity {
  const _$DocumentEntityImpl(
      {required this.id,
      required this.userId,
      required this.eventId,
      required this.title,
      required this.filePath,
      required this.documentType,
      required this.uploadedAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String? eventId;
  @override
  final String title;
  @override
  final String filePath;
  @override
  final DocumentType documentType;
  @override
  final DateTime uploadedAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'DocumentEntity(id: $id, userId: $userId, eventId: $eventId, title: $title, filePath: $filePath, documentType: $documentType, uploadedAt: $uploadedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      eventId,
      title,
      filePath,
      documentType,
      uploadedAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of DocumentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentEntityImplCopyWith<_$DocumentEntityImpl> get copyWith =>
      __$$DocumentEntityImplCopyWithImpl<_$DocumentEntityImpl>(
          this, _$identity);
}

abstract class _DocumentEntity extends DocumentEntity {
  const factory _DocumentEntity(
      {required final String id,
      required final String userId,
      required final String? eventId,
      required final String title,
      required final String filePath,
      required final DocumentType documentType,
      required final DateTime uploadedAt,
      final Map<String, dynamic>? metadata}) = _$DocumentEntityImpl;
  const _DocumentEntity._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String? get eventId;
  @override
  String get title;
  @override
  String get filePath;
  @override
  DocumentType get documentType;
  @override
  DateTime get uploadedAt;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of DocumentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentEntityImplCopyWith<_$DocumentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
