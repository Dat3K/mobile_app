import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/core/models/event.dart';
import 'package:mobile_app/core/models/user.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/event_service.dart';
import '../../features/auth/view_models/auth_view_model.dart';
import '../../features/student/view_models/student_event_view_model.dart';
import '../../features/enterprise/view_models/enterprise_event_view_model.dart';
import 'package:get_it/get_it.dart';

final authServiceProvider = Provider<AuthService>((ref) => GetIt.instance<AuthService>());
final eventServiceProvider = Provider<EventService>((ref) => GetIt.instance<EventService>());

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  return AuthViewModel(ref.watch(authServiceProvider));
});

final studentEventViewModelProvider = StateNotifierProvider<StudentEventViewModel, AsyncValue<List<Event>>>((ref) {
  return StudentEventViewModel(ref.watch(eventServiceProvider));
});

final enterpriseEventViewModelProvider = StateNotifierProvider<EnterpriseEventViewModel, AsyncValue<List<Event>>>((ref) {
  return EnterpriseEventViewModel(ref.watch(eventServiceProvider));
});