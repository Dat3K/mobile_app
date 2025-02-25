// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enterprise_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EnterpriseEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get industry => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of EnterpriseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnterpriseEntityCopyWith<EnterpriseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnterpriseEntityCopyWith<$Res> {
  factory $EnterpriseEntityCopyWith(
          EnterpriseEntity value, $Res Function(EnterpriseEntity) then) =
      _$EnterpriseEntityCopyWithImpl<$Res, EnterpriseEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String industry,
      String imagePath,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$EnterpriseEntityCopyWithImpl<$Res, $Val extends EnterpriseEntity>
    implements $EnterpriseEntityCopyWith<$Res> {
  _$EnterpriseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnterpriseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? industry = null,
    Object? imagePath = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnterpriseEntityImplCopyWith<$Res>
    implements $EnterpriseEntityCopyWith<$Res> {
  factory _$$EnterpriseEntityImplCopyWith(_$EnterpriseEntityImpl value,
          $Res Function(_$EnterpriseEntityImpl) then) =
      __$$EnterpriseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String industry,
      String imagePath,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$EnterpriseEntityImplCopyWithImpl<$Res>
    extends _$EnterpriseEntityCopyWithImpl<$Res, _$EnterpriseEntityImpl>
    implements _$$EnterpriseEntityImplCopyWith<$Res> {
  __$$EnterpriseEntityImplCopyWithImpl(_$EnterpriseEntityImpl _value,
      $Res Function(_$EnterpriseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnterpriseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? industry = null,
    Object? imagePath = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$EnterpriseEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$EnterpriseEntityImpl extends _EnterpriseEntity {
  const _$EnterpriseEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.industry,
      required this.imagePath,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String industry;
  @override
  final String imagePath;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'EnterpriseEntity(id: $id, name: $name, description: $description, industry: $industry, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterpriseEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, industry,
      imagePath, createdAt, updatedAt);

  /// Create a copy of EnterpriseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterpriseEntityImplCopyWith<_$EnterpriseEntityImpl> get copyWith =>
      __$$EnterpriseEntityImplCopyWithImpl<_$EnterpriseEntityImpl>(
          this, _$identity);
}

abstract class _EnterpriseEntity extends EnterpriseEntity {
  const factory _EnterpriseEntity(
      {required final String id,
      required final String name,
      required final String description,
      required final String industry,
      required final String imagePath,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$EnterpriseEntityImpl;
  const _EnterpriseEntity._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get industry;
  @override
  String get imagePath;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of EnterpriseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnterpriseEntityImplCopyWith<_$EnterpriseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
