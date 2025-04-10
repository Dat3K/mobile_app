import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_app/core/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../domain/repositories/student_repository.dart';
import 'data_source_providers.dart';

part 'repository_providers.g.dart';

/// Provider for StudentRepository
@Riverpod(keepAlive: true)
IStudentRepository studentRepository(Ref ref) {
  final localDataSource = ref.watch(studentLocalDataSourceProvider);
  final remoteDataSource = ref.watch(studentRemoteDataSourceProvider);
  final logger = ref.watch(loggerServiceProvider);
  
  return StudentRepository(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    logger: logger,
  );
}
