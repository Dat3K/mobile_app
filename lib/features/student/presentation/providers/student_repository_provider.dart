import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/features/student/data/repositories/student_repository_impl.dart';
import 'package:mobile_app/features/student/domain/repositories/student_repository.dart';
import 'package:mobile_app/features/student/presentation/providers/student_data_source_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_repository_provider.g.dart';

@Riverpod(keepAlive: true)
IStudentRepository studentRepository(Ref ref) {
  final localDataSource = ref.watch(studentLocalDataSourceProvider);
  final remoteDataSource = ref.watch(studentRemoteDataSourceProvider);
  return StudentRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource);
}
