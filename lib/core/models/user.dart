import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 0)
  factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String role,
    @HiveField(3) required String fullName,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}