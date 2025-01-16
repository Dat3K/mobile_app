// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) {
  return _SessionModel.fromJson(json);
}

/// @nodoc
mixin _$SessionModel {
  @JsonKey(name: 'access_token')
  @HiveField(0)
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  @HiveField(1)
  String get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  @HiveField(2)
  int get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  @HiveField(3)
  int get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this SessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionModelCopyWith<SessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionModelCopyWith<$Res> {
  factory $SessionModelCopyWith(
          SessionModel value, $Res Function(SessionModel) then) =
      _$SessionModelCopyWithImpl<$Res, SessionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') @HiveField(0) String accessToken,
      @JsonKey(name: 'refresh_token') @HiveField(1) String refreshToken,
      @JsonKey(name: 'expires_in') @HiveField(2) int expiresIn,
      @JsonKey(name: 'expires_at') @HiveField(3) int expiresAt});
}

/// @nodoc
class _$SessionModelCopyWithImpl<$Res, $Val extends SessionModel>
    implements $SessionModelCopyWith<$Res> {
  _$SessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionModelImplCopyWith<$Res>
    implements $SessionModelCopyWith<$Res> {
  factory _$$SessionModelImplCopyWith(
          _$SessionModelImpl value, $Res Function(_$SessionModelImpl) then) =
      __$$SessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') @HiveField(0) String accessToken,
      @JsonKey(name: 'refresh_token') @HiveField(1) String refreshToken,
      @JsonKey(name: 'expires_in') @HiveField(2) int expiresIn,
      @JsonKey(name: 'expires_at') @HiveField(3) int expiresAt});
}

/// @nodoc
class __$$SessionModelImplCopyWithImpl<$Res>
    extends _$SessionModelCopyWithImpl<$Res, _$SessionModelImpl>
    implements _$$SessionModelImplCopyWith<$Res> {
  __$$SessionModelImplCopyWithImpl(
      _$SessionModelImpl _value, $Res Function(_$SessionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? expiresAt = null,
  }) {
    return _then(_$SessionModelImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionModelImpl extends _SessionModel {
  const _$SessionModelImpl(
      {@JsonKey(name: 'access_token') @HiveField(0) required this.accessToken,
      @JsonKey(name: 'refresh_token') @HiveField(1) required this.refreshToken,
      @JsonKey(name: 'expires_in') @HiveField(2) required this.expiresIn,
      @JsonKey(name: 'expires_at') @HiveField(3) required this.expiresAt})
      : super._();

  factory _$SessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionModelImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  @HiveField(0)
  final String accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  @HiveField(1)
  final String refreshToken;
  @override
  @JsonKey(name: 'expires_in')
  @HiveField(2)
  final int expiresIn;
  @override
  @JsonKey(name: 'expires_at')
  @HiveField(3)
  final int expiresAt;

  @override
  String toString() {
    return 'SessionModel(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresIn, expiresAt);

  /// Create a copy of SessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionModelImplCopyWith<_$SessionModelImpl> get copyWith =>
      __$$SessionModelImplCopyWithImpl<_$SessionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionModelImplToJson(
      this,
    );
  }
}

abstract class _SessionModel extends SessionModel {
  const factory _SessionModel(
      {@JsonKey(name: 'access_token')
      @HiveField(0)
      required final String accessToken,
      @JsonKey(name: 'refresh_token')
      @HiveField(1)
      required final String refreshToken,
      @JsonKey(name: 'expires_in') @HiveField(2) required final int expiresIn,
      @JsonKey(name: 'expires_at')
      @HiveField(3)
      required final int expiresAt}) = _$SessionModelImpl;
  const _SessionModel._() : super._();

  factory _SessionModel.fromJson(Map<String, dynamic> json) =
      _$SessionModelImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  @HiveField(0)
  String get accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  @HiveField(1)
  String get refreshToken;
  @override
  @JsonKey(name: 'expires_in')
  @HiveField(2)
  int get expiresIn;
  @override
  @JsonKey(name: 'expires_at')
  @HiveField(3)
  int get expiresAt;

  /// Create a copy of SessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionModelImplCopyWith<_$SessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
