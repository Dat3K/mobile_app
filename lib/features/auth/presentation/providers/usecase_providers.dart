import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_app/features/auth/domain/usecases/logout_usecase.dart';
import 'repository_providers.dart';

part 'usecase_providers.g.dart';

/// Provider cho LoginUseCase
@riverpod
LoginUseCase loginUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository: repository);
}

/// Provider cho LogoutUseCase
@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository: repository);
}

/// Provider cho CheckAuthUseCase
@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository: repository);
}