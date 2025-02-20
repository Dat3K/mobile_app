// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get creatorId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get title => throw _privateConstructorUsedError;
  @HiveField(3)
  String get description => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get endDate => throw _privateConstructorUsedError;
  @HiveField(6)
  EventTypeModel get eventType => throw _privateConstructorUsedError;
  @HiveField(7)
  EventStatusModel get status => throw _privateConstructorUsedError;
  @HiveField(8)
  int get positionsAvailable => throw _privateConstructorUsedError;
  @HiveField(9)
  int get maxParticipants => throw _privateConstructorUsedError;
  @HiveField(10)
  String get location => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime get applicationDeadline => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  @HiveField(13)
  Map<String, dynamic> get additionalFields =>
      throw _privateConstructorUsedError;
  @HiveField(14)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(15)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String creatorId,
      @HiveField(2) String title,
      @HiveField(3) String description,
      @HiveField(4) DateTime startDate,
      @HiveField(5) DateTime endDate,
      @HiveField(6) EventTypeModel eventType,
      @HiveField(7) EventStatusModel status,
      @HiveField(8) int positionsAvailable,
      @HiveField(9) int maxParticipants,
      @HiveField(10) String location,
      @HiveField(11) DateTime applicationDeadline,
      @HiveField(12) List<String> requiredSkills,
      @HiveField(13) Map<String, dynamic> additionalFields,
      @HiveField(14) DateTime createdAt,
      @HiveField(15) DateTime updatedAt});
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
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
              as EventTypeModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatusModel,
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
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String creatorId,
      @HiveField(2) String title,
      @HiveField(3) String description,
      @HiveField(4) DateTime startDate,
      @HiveField(5) DateTime endDate,
      @HiveField(6) EventTypeModel eventType,
      @HiveField(7) EventStatusModel status,
      @HiveField(8) int positionsAvailable,
      @HiveField(9) int maxParticipants,
      @HiveField(10) String location,
      @HiveField(11) DateTime applicationDeadline,
      @HiveField(12) List<String> requiredSkills,
      @HiveField(13) Map<String, dynamic> additionalFields,
      @HiveField(14) DateTime createdAt,
      @HiveField(15) DateTime updatedAt});
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventModel
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
    return _then(_$EventModelImpl(
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
              as EventTypeModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EventStatusModel,
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
@JsonSerializable()
class _$EventModelImpl extends _EventModel {
  const _$EventModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.creatorId,
      @HiveField(2) required this.title,
      @HiveField(3) required this.description,
      @HiveField(4) required this.startDate,
      @HiveField(5) required this.endDate,
      @HiveField(6) required this.eventType,
      @HiveField(7) required this.status,
      @HiveField(8) required this.positionsAvailable,
      @HiveField(9) required this.maxParticipants,
      @HiveField(10) required this.location,
      @HiveField(11) required this.applicationDeadline,
      @HiveField(12) required final List<String> requiredSkills,
      @HiveField(13) required final Map<String, dynamic> additionalFields,
      @HiveField(14) required this.createdAt,
      @HiveField(15) required this.updatedAt})
      : _requiredSkills = requiredSkills,
        _additionalFields = additionalFields,
        super._();

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String creatorId;
  @override
  @HiveField(2)
  final String title;
  @override
  @HiveField(3)
  final String description;
  @override
  @HiveField(4)
  final DateTime startDate;
  @override
  @HiveField(5)
  final DateTime endDate;
  @override
  @HiveField(6)
  final EventTypeModel eventType;
  @override
  @HiveField(7)
  final EventStatusModel status;
  @override
  @HiveField(8)
  final int positionsAvailable;
  @override
  @HiveField(9)
  final int maxParticipants;
  @override
  @HiveField(10)
  final String location;
  @override
  @HiveField(11)
  final DateTime applicationDeadline;
  final List<String> _requiredSkills;
  @override
  @HiveField(12)
  List<String> get requiredSkills {
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSkills);
  }

  final Map<String, dynamic> _additionalFields;
  @override
  @HiveField(13)
  Map<String, dynamic> get additionalFields {
    if (_additionalFields is EqualUnmodifiableMapView) return _additionalFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalFields);
  }

  @override
  @HiveField(14)
  final DateTime createdAt;
  @override
  @HiveField(15)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'EventModel(id: $id, creatorId: $creatorId, title: $title, description: $description, startDate: $startDate, endDate: $endDate, eventType: $eventType, status: $status, positionsAvailable: $positionsAvailable, maxParticipants: $maxParticipants, location: $location, applicationDeadline: $applicationDeadline, requiredSkills: $requiredSkills, additionalFields: $additionalFields, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(
      this,
    );
  }
}

abstract class _EventModel extends EventModel {
  const factory _EventModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String creatorId,
      @HiveField(2) required final String title,
      @HiveField(3) required final String description,
      @HiveField(4) required final DateTime startDate,
      @HiveField(5) required final DateTime endDate,
      @HiveField(6) required final EventTypeModel eventType,
      @HiveField(7) required final EventStatusModel status,
      @HiveField(8) required final int positionsAvailable,
      @HiveField(9) required final int maxParticipants,
      @HiveField(10) required final String location,
      @HiveField(11) required final DateTime applicationDeadline,
      @HiveField(12) required final List<String> requiredSkills,
      @HiveField(13) required final Map<String, dynamic> additionalFields,
      @HiveField(14) required final DateTime createdAt,
      @HiveField(15) required final DateTime updatedAt}) = _$EventModelImpl;
  const _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get creatorId;
  @override
  @HiveField(2)
  String get title;
  @override
  @HiveField(3)
  String get description;
  @override
  @HiveField(4)
  DateTime get startDate;
  @override
  @HiveField(5)
  DateTime get endDate;
  @override
  @HiveField(6)
  EventTypeModel get eventType;
  @override
  @HiveField(7)
  EventStatusModel get status;
  @override
  @HiveField(8)
  int get positionsAvailable;
  @override
  @HiveField(9)
  int get maxParticipants;
  @override
  @HiveField(10)
  String get location;
  @override
  @HiveField(11)
  DateTime get applicationDeadline;
  @override
  @HiveField(12)
  List<String> get requiredSkills;
  @override
  @HiveField(13)
  Map<String, dynamic> get additionalFields;
  @override
  @HiveField(14)
  DateTime get createdAt;
  @override
  @HiveField(15)
  DateTime get updatedAt;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
