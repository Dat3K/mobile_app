// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enterprise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EnterpriseModel _$EnterpriseModelFromJson(Map<String, dynamic> json) {
  return _EnterpriseModel.fromJson(json);
}

/// @nodoc
mixin _$EnterpriseModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String get industry => throw _privateConstructorUsedError;
  @HiveField(4)
  String get imagePath => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EnterpriseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnterpriseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnterpriseModelCopyWith<EnterpriseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnterpriseModelCopyWith<$Res> {
  factory $EnterpriseModelCopyWith(
          EnterpriseModel value, $Res Function(EnterpriseModel) then) =
      _$EnterpriseModelCopyWithImpl<$Res, EnterpriseModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String industry,
      @HiveField(4) String imagePath,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime updatedAt});
}

/// @nodoc
class _$EnterpriseModelCopyWithImpl<$Res, $Val extends EnterpriseModel>
    implements $EnterpriseModelCopyWith<$Res> {
  _$EnterpriseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnterpriseModel
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
abstract class _$$EnterpriseModelImplCopyWith<$Res>
    implements $EnterpriseModelCopyWith<$Res> {
  factory _$$EnterpriseModelImplCopyWith(_$EnterpriseModelImpl value,
          $Res Function(_$EnterpriseModelImpl) then) =
      __$$EnterpriseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String description,
      @HiveField(3) String industry,
      @HiveField(4) String imagePath,
      @HiveField(5) DateTime createdAt,
      @HiveField(6) DateTime updatedAt});
}

/// @nodoc
class __$$EnterpriseModelImplCopyWithImpl<$Res>
    extends _$EnterpriseModelCopyWithImpl<$Res, _$EnterpriseModelImpl>
    implements _$$EnterpriseModelImplCopyWith<$Res> {
  __$$EnterpriseModelImplCopyWithImpl(
      _$EnterpriseModelImpl _value, $Res Function(_$EnterpriseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnterpriseModel
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
    return _then(_$EnterpriseModelImpl(
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
@JsonSerializable()
class _$EnterpriseModelImpl extends _EnterpriseModel {
  const _$EnterpriseModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.description,
      @HiveField(3) required this.industry,
      @HiveField(4) required this.imagePath,
      @HiveField(5) required this.createdAt,
      @HiveField(6) required this.updatedAt})
      : super._();

  factory _$EnterpriseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnterpriseModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String industry;
  @override
  @HiveField(4)
  final String imagePath;
  @override
  @HiveField(5)
  final DateTime createdAt;
  @override
  @HiveField(6)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'EnterpriseModel(id: $id, name: $name, description: $description, industry: $industry, imagePath: $imagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterpriseModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, industry,
      imagePath, createdAt, updatedAt);

  /// Create a copy of EnterpriseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterpriseModelImplCopyWith<_$EnterpriseModelImpl> get copyWith =>
      __$$EnterpriseModelImplCopyWithImpl<_$EnterpriseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnterpriseModelImplToJson(
      this,
    );
  }
}

abstract class _EnterpriseModel extends EnterpriseModel {
  const factory _EnterpriseModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String description,
      @HiveField(3) required final String industry,
      @HiveField(4) required final String imagePath,
      @HiveField(5) required final DateTime createdAt,
      @HiveField(6) required final DateTime updatedAt}) = _$EnterpriseModelImpl;
  const _EnterpriseModel._() : super._();

  factory _EnterpriseModel.fromJson(Map<String, dynamic> json) =
      _$EnterpriseModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String get industry;
  @override
  @HiveField(4)
  String get imagePath;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @HiveField(6)
  DateTime get updatedAt;

  /// Create a copy of EnterpriseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnterpriseModelImplCopyWith<_$EnterpriseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
