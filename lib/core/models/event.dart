import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  @HiveType(typeId: 1)
  factory Event({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required DateTime startDate,
    @HiveField(4) required DateTime endDate,
    @HiveField(5) required String eventType,
    @HiveField(6) required String status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}