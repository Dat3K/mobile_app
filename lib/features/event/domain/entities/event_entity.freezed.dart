// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EventEntity {
  String get id => throw _privateConstructorUsedError;
  String get creatorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  int get positionsAvailable => throw _privateConstructorUsedError;
  int get maxParticipants => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get applicationDeadline => throw _privateConstructorUsedError;
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalFields =>
      throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of EventEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventEntityCopyWith<EventEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventEntityCopyWith<$Res> {
  factory $EventEntityCopyWith(
          EventEntity value, $Res Function(EventEntity) then) =
      _$EventEntityCopyWithImpl<$Res, EventEntity>;
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String title,
      String description,
      DateTime startDate,
      DateTime endDate,
      EventType eventType,
      EventStatus status,
      int positionsAvailable,
      int maxParticipants,
      String location,
      DateTime applicationDeadline,
      List<String> requiredSkills,
      Map<String, dynamic> additionalFields,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$EventEntityCopyWithImpl<$Res, $Val extends EventEntity>
    implements $EventEntityCopyWith<$Res> {
  _$EventEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eventType = null,
    Object? status = null,
    Object? positionsAvailable = null,
    Object? maxParticipants = null,
    Object? location = null,
    Object? applicationDeadline = null,
    Object? requiredSkills = null,
    Object? additionalFields = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      positionsAvailable: null == positionsAvailable
          ? _value.positionsAvailable
          : positionsAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      applicationDeadline: null == applicationDeadline
          ? _value.applicationDeadline
          : applicationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredSkills: null == requiredSkills
          ? _value.requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalFields: null == additionalFields
          ? _value.additionalFields
          : additionalFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
abstract class _$$EventEntityImplCopyWith<$Res>
    implements $EventEntityCopyWith<$Res> {
  factory _$$EventEntityImplCopyWith(
          _$EventEntityImpl value, $Res Function(_$EventEntityImpl) then) =
      __$$EventEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorId,
      String title,
      String description,
      DateTime startDate,
      DateTime endDate,
      EventType eventType,
      EventStatus status,
      int positionsAvailable,
      int maxParticipants,
      String location,
      DateTime applicationDeadline,
      List<String> requiredSkills,
      Map<String, dynamic> additionalFields,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$EventEntityImplCopyWithImpl<$Res>
    extends _$EventEntityCopyWithImpl<$Res, _$EventEntityImpl>
    implements _$$EventEntityImplCopyWith<$Res> {
  __$$EventEntityImplCopyWithImpl(
      _$EventEntityImpl _value, $Res Function(_$EventEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorId = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? eventType = null,
    Object? status = null,
    Object? positionsAvailable = null,
    Object? maxParticipants = null,
    Object? location = null,
    Object? applicationDeadline = null,
    Object? requiredSkills = null,
    Object? additionalFields = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$EventEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatus,
      positionsAvailable: null == positionsAvailable
          ? _value.positionsAvailable
          : positionsAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      applicationDeadline: null == applicationDeadline
          ? _value.applicationDeadline
          : applicationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requiredSkills: null == requiredSkills
          ? _value._requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalFields: null == additionalFields
          ? _value._additionalFields
          : additionalFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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

class _$EventEntityImpl extends _EventEntity {
  const _$EventEntityImpl(
      {required this.id,
      required this.creatorId,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.eventType,
      required this.status,
      required this.positionsAvailable,
      required this.maxParticipants,
      required this.location,
      required this.applicationDeadline,
      required final List<String> requiredSkills,
      required final Map<String, dynamic> additionalFields,
      required this.createdAt,
      required this.updatedAt})
      : _requiredSkills = requiredSkills,
        _additionalFields = additionalFields,
        super._();

  @override
  final String id;
  @override
  final String creatorId;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final EventType eventType;
  @override
  final EventStatus status;
  @override
  final int positionsAvailable;
  @override
  final int maxParticipants;
  @override
  final String location;
  @override
  final DateTime applicationDeadline;
  final List<String> _requiredSkills;
  @override
  List<String> get requiredSkills {
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSkills);
  }

  final Map<String, dynamic> _additionalFields;
  @override
  Map<String, dynamic> get additionalFields {
    if (_additionalFields is EqualUnmodifiableMapView) return _additionalFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalFields);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'EventEntity(id: $id, creatorId: $creatorId, title: $title, description: $description, startDate: $startDate, endDate: $endDate, eventType: $eventType, status: $status, positionsAvailable: $positionsAvailable, maxParticipants: $maxParticipants, location: $location, applicationDeadline: $applicationDeadline, requiredSkills: $requiredSkills, additionalFields: $additionalFields, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.positionsAvailable, positionsAvailable) ||
                other.positionsAvailable == positionsAvailable) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.applicationDeadline, applicationDeadline) ||
                other.applicationDeadline == applicationDeadline) &&
            const DeepCollectionEquality()
                .equals(other._requiredSkills, _requiredSkills) &&
            const DeepCollectionEquality()
                .equals(other._additionalFields, _additionalFields) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      creatorId,
      title,
      description,
      startDate,
      endDate,
      eventType,
      status,
      positionsAvailable,
      maxParticipants,
      location,
      applicationDeadline,
      const DeepCollectionEquality().hash(_requiredSkills),
      const DeepCollectionEquality().hash(_additionalFields),
      createdAt,
      updatedAt);

  /// Create a copy of EventEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventEntityImplCopyWith<_$EventEntityImpl> get copyWith =>
      __$$EventEntityImplCopyWithImpl<_$EventEntityImpl>(this, _$identity);
}

abstract class _EventEntity extends EventEntity {
  const factory _EventEntity(
      {required final String id,
      required final String creatorId,
      required final String title,
      required final String description,
      required final DateTime startDate,
      required final DateTime endDate,
      required final EventType eventType,
      required final EventStatus status,
      required final int positionsAvailable,
      required final int maxParticipants,
      required final String location,
      required final DateTime applicationDeadline,
      required final List<String> requiredSkills,
      required final Map<String, dynamic> additionalFields,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$EventEntityImpl;
  const _EventEntity._() : super._();

  @override
  String get id;
  @override
  String get creatorId;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  EventType get eventType;
  @override
  EventStatus get status;
  @override
  int get positionsAvailable;
  @override
  int get maxParticipants;
  @override
  String get location;
  @override
  DateTime get applicationDeadline;
  @override
  List<String> get requiredSkills;
  @override
  Map<String, dynamic> get additionalFields;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of EventEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventEntityImplCopyWith<_$EventEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
