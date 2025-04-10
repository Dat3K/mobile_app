import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/error/failures.dart';
import 'package:mobile_app/core/models/pagination/paging_model.dart';
import 'package:mobile_app/core/usecases/usecase.dart';
import '../../data/models/student_filter_model.dart';
import '../entities/student_entity.dart';
import '../repositories/student_repository.dart';

class GetStudentsParams {
  final StudentFilterModel? filter;
  final PagingModel? paging;

  GetStudentsParams({
    this.filter,
    this.paging,
  });
}

class GetStudentsUseCase implements UseCase<PaginatedResult<StudentEntity>, GetStudentsParams> {
  final IStudentRepository _repository;

  GetStudentsUseCase(this._repository);

  @override
  Future<Either<Failure, PaginatedResult<StudentEntity>>> call(GetStudentsParams params) {
    return _repository.getStudents(
      filter: params.filter,
      paging: params.paging,
    );
  }
}
