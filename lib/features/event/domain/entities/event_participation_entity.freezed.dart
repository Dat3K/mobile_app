// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_participation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventParticipationEntity {
  String get id => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  ParticipationRole get role => throw _privateConstructorUsedError;
  ParticipationStatus get status => throw _privateConstructorUsedError;
  bool get attendance => throw _privateConstructorUsedError;
  DateTime get registeredAt => throw _privateConstructorUsedError;
  DateTime? get interviewTime => throw _privateConstructorUsedError;
  String? get interviewNotes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalData =>
      throw _privateConstructorUsedError;

  /// Create a copy of EventParticipationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventParticipationEntityCopyWith<EventParticipationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventParticipationEntityCopyWith<$Res> {
  factory $EventParticipationEntityCopyWith(EventParticipationEntity value,
          $Res Function(EventParticipationEntity) then) =
      _$EventParticipationEntityCopyWithImpl<$Res, EventParticipationEntity>;
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      ParticipationRole role,
      ParticipationStatus status,
      bool attendance,
      DateTime registeredAt,
      DateTime? interviewTime,
      String? interviewNotes,
      Map<String, dynamic>? additionalData});
}

/// @nodoc
class _$EventParticipationEntityCopyWithImpl<$Res,
        $Val extends EventParticipationEntity>
    implements $EventParticipationEntityCopyWith<$Res> {
  _$EventParticipationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventParticipationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? attendance = null,
    Object? registeredAt = null,
    Object? interviewTime = freezed,
    Object? interviewNotes = freezed,
    Object? additionalData = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as ParticipationRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatus,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interviewTime: freezed == interviewTime
          ? _value.interviewTime
          : interviewTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      interviewNotes: freezed == interviewNotes
          ? _value.interviewNotes
          : interviewNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalData: freezed == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventParticipationEntityImplCopyWith<$Res>
    implements $EventParticipationEntityCopyWith<$Res> {
  factory _$$EventParticipationEntityImplCopyWith(
          _$EventParticipationEntityImpl value,
          $Res Function(_$EventParticipationEntityImpl) then) =
      __$$EventParticipationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      ParticipationRole role,
      ParticipationStatus status,
      bool attendance,
      DateTime registeredAt,
      DateTime? interviewTime,
      String? interviewNotes,
      Map<String, dynamic>? additionalData});
}

/// @nodoc
class __$$EventParticipationEntityImplCopyWithImpl<$Res>
    extends _$EventParticipationEntityCopyWithImpl<$Res,
        _$EventParticipationEntityImpl>
    implements _$$EventParticipationEntityImplCopyWith<$Res> {
  __$$EventParticipationEntityImplCopyWithImpl(
      _$EventParticipationEntityImpl _value,
      $Res Function(_$EventParticipationEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventParticipationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? attendance = null,
    Object? registeredAt = null,
    Object? interviewTime = freezed,
    Object? interviewNotes = freezed,
    Object? additionalData = freezed,
  }) {
    return _then(_$EventParticipationEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as ParticipationRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatus,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as bool,
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interviewTime: freezed == interviewTime
          ? _value.interviewTime
          : interviewTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      interviewNotes: freezed == interviewNotes
          ? _value.interviewNotes
          : interviewNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalData: freezed == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$EventParticipationEntityImpl extends _EventParticipationEntity {
  const _$EventParticipationEntityImpl(
      {required this.id,
      required this.eventId,
      required this.userId,
      required this.role,
      required this.status,
      required this.attendance,
      required this.registeredAt,
      this.interviewTime,
      this.interviewNotes,
      final Map<String, dynamic>? additionalData})
      : _additionalData = additionalData,
        super._();

  @override
  final String id;
  @override
  final String eventId;
  @override
  final String userId;
  @override
  final ParticipationRole role;
  @override
  final ParticipationStatus status;
  @override
  final bool attendance;
  @override
  final DateTime registeredAt;
  @override
  final DateTime? interviewTime;
  @override
  final String? interviewNotes;
  final Map<String, dynamic>? _additionalData;
  @override
  Map<String, dynamic>? get additionalData {
    final value = _additionalData;
    if (value == null) return null;
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EventParticipationEntity(id: $id, eventId: $eventId, userId: $userId, role: $role, status: $status, attendance: $attendance, registeredAt: $registeredAt, interviewTime: $interviewTime, interviewNotes: $interviewNotes, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventParticipationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.interviewTime, interviewTime) ||
                other.interviewTime == interviewTime) &&
            (identical(other.interviewNotes, interviewNotes) ||
                other.interviewNotes == interviewNotes) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eventId,
      userId,
      role,
      status,
      attendance,
      registeredAt,
      interviewTime,
      interviewNotes,
      const DeepCollectionEquality().hash(_additionalData));

  /// Create a copy of EventParticipationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventParticipationEntityImplCopyWith<_$EventParticipationEntityImpl>
      get copyWith => __$$EventParticipationEntityImplCopyWithImpl<
          _$EventParticipationEntityImpl>(this, _$identity);
}

abstract class _EventParticipationEntity extends EventParticipationEntity {
  const factory _EventParticipationEntity(
          {required final String id,
          required final String eventId,
          required final String userId,
          required final ParticipationRole role,
          required final ParticipationStatus status,
          required final bool attendance,
          required final DateTime registeredAt,
          final DateTime? interviewTime,
          final String? interviewNotes,
          final Map<String, dynamic>? additionalData}) =
      _$EventParticipationEntityImpl;
  const _EventParticipationEntity._() : super._();

  @override
  String get id;
  @override
  String get eventId;
  @override
  String get userId;
  @override
  ParticipationRole get role;
  @override
  ParticipationStatus get status;
  @override
  bool get attendance;
  @override
  DateTime get registeredAt;
  @override
  DateTime? get interviewTime;
  @override
  String? get interviewNotes;
  @override
  Map<String, dynamic>? get additionalData;

  /// Create a copy of EventParticipationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventParticipationEntityImplCopyWith<_$EventParticipationEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
