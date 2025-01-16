import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required int expiresAt,
  }) = _Session;
}
