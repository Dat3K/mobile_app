// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_participation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventParticipationModel _$EventParticipationModelFromJson(
    Map<String, dynamic> json) {
  return _EventParticipationModel.fromJson(json);
}

/// @nodoc
mixin _$EventParticipationModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get eventId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(3)
  ParticipationRoleModel get role => throw _privateConstructorUsedError;
  @HiveField(4)
  ParticipationStatusModel get status => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get attendance => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get registeredAt => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get interviewTime => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get interviewNotes => throw _privateConstructorUsedError;
  @HiveField(9)
  Map<String, dynamic>? get additionalData =>
      throw _privateConstructorUsedError;

  /// Serializes this EventParticipationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventParticipationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventParticipationModelCopyWith<EventParticipationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventParticipationModelCopyWith<$Res> {
  factory $EventParticipationModelCopyWith(EventParticipationModel value,
          $Res Function(EventParticipationModel) then) =
      _$EventParticipationModelCopyWithImpl<$Res, EventParticipationModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String eventId,
      @HiveField(2) String userId,
      @HiveField(3) ParticipationRoleModel role,
      @HiveField(4) ParticipationStatusModel status,
      @HiveField(5) bool attendance,
      @HiveField(6) DateTime registeredAt,
      @HiveField(7) DateTime? interviewTime,
      @HiveField(8) String? interviewNotes,
      @HiveField(9) Map<String, dynamic>? additionalData});
}

/// @nodoc
class _$EventParticipationModelCopyWithImpl<$Res,
        $Val extends EventParticipationModel>
    implements $EventParticipationModelCopyWith<$Res> {
  _$EventParticipationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventParticipationModel
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
              as ParticipationRoleModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatusModel,
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
abstract class _$$EventParticipationModelImplCopyWith<$Res>
    implements $EventParticipationModelCopyWith<$Res> {
  factory _$$EventParticipationModelImplCopyWith(
          _$EventParticipationModelImpl value,
          $Res Function(_$EventParticipationModelImpl) then) =
      __$$EventParticipationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String eventId,
      @HiveField(2) String userId,
      @HiveField(3) ParticipationRoleModel role,
      @HiveField(4) ParticipationStatusModel status,
      @HiveField(5) bool attendance,
      @HiveField(6) DateTime registeredAt,
      @HiveField(7) DateTime? interviewTime,
      @HiveField(8) String? interviewNotes,
      @HiveField(9) Map<String, dynamic>? additionalData});
}

/// @nodoc
class __$$EventParticipationModelImplCopyWithImpl<$Res>
    extends _$EventParticipationModelCopyWithImpl<$Res,
        _$EventParticipationModelImpl>
    implements _$$EventParticipationModelImplCopyWith<$Res> {
  __$$EventParticipationModelImplCopyWithImpl(
      _$EventParticipationModelImpl _value,
      $Res Function(_$EventParticipationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventParticipationModel
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
    return _then(_$EventParticipationModelImpl(
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
              as ParticipationRoleModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatusModel,
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
@JsonSerializable()
class _$EventParticipationModelImpl extends _EventParticipationModel {
  const _$EventParticipationModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.eventId,
      @HiveField(2) required this.userId,
      @HiveField(3) required this.role,
      @HiveField(4) required this.status,
      @HiveField(5) required this.attendance,
      @HiveField(6) required this.registeredAt,
      @HiveField(7) this.interviewTime,
      @HiveField(8) this.interviewNotes,
      @HiveField(9) final Map<String, dynamic>? additionalData})
      : _additionalData = additionalData,
        super._();

  factory _$EventParticipationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventParticipationModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String eventId;
  @override
  @HiveField(2)
  final String userId;
  @override
  @HiveField(3)
  final ParticipationRoleModel role;
  @override
  @HiveField(4)
  final ParticipationStatusModel status;
  @override
  @HiveField(5)
  final bool attendance;
  @override
  @HiveField(6)
  final DateTime registeredAt;
  @override
  @HiveField(7)
  final DateTime? interviewTime;
  @override
  @HiveField(8)
  final String? interviewNotes;
  final Map<String, dynamic>? _additionalData;
  @override
  @HiveField(9)
  Map<String, dynamic>? get additionalData {
    final value = _additionalData;
    if (value == null) return null;
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EventParticipationModel(id: $id, eventId: $eventId, userId: $userId, role: $role, status: $status, attendance: $attendance, registeredAt: $registeredAt, interviewTime: $interviewTime, interviewNotes: $interviewNotes, additionalData: $additionalData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventParticipationModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of EventParticipationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventParticipationModelImplCopyWith<_$EventParticipationModelImpl>
      get copyWith => __$$EventParticipationModelImplCopyWithImpl<
          _$EventParticipationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventParticipationModelImplToJson(
      this,
    );
  }
}

abstract class _EventParticipationModel extends EventParticipationModel {
  const factory _EventParticipationModel(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String eventId,
          @HiveField(2) required final String userId,
          @HiveField(3) required final ParticipationRoleModel role,
          @HiveField(4) required final ParticipationStatusModel status,
          @HiveField(5) required final bool attendance,
          @HiveField(6) required final DateTime registeredAt,
          @HiveField(7) final DateTime? interviewTime,
          @HiveField(8) final String? interviewNotes,
          @HiveField(9) final Map<String, dynamic>? additionalData}) =
      _$EventParticipationModelImpl;
  const _EventParticipationModel._() : super._();

  factory _EventParticipationModel.fromJson(Map<String, dynamic> json) =
      _$EventParticipationModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get eventId;
  @override
  @HiveField(2)
  String get userId;
  @override
  @HiveField(3)
  ParticipationRoleModel get role;
  @override
  @HiveField(4)
  ParticipationStatusModel get status;
  @override
  @HiveField(5)
  bool get attendance;
  @override
  @HiveField(6)
  DateTime get registeredAt;
  @override
  @HiveField(7)
  DateTime? get interviewTime;
  @override
  @HiveField(8)
  String? get interviewNotes;
  @override
  @HiveField(9)
  Map<String, dynamic>? get additionalData;

  /// Create a copy of EventParticipationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventParticipationModelImplCopyWith<_$EventParticipationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
