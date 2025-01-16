import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/session.dart';

part 'session_model.g.dart';
part 'session_model.freezed.dart';

@freezed
@HiveType(typeId: 2)
class SessionModel with _$SessionModel {
  const factory SessionModel({
    @HiveField(0) required String accessToken,
    @HiveField(1) required String refreshToken,
    @HiveField(2) required int expiresIn,
    @HiveField(3) required int expiresAt,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  const SessionModel._();

  Session toDomain() => Session(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
        expiresAt: expiresAt,
      );
}
