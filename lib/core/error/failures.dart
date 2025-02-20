import 'package:equatable/equatable.dart';

/// Base failure class that all other failures must extend
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Network related failures
abstract class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends NetworkFailure {
  const ServerFailure(super.message);

  factory ServerFailure.internal() => const ServerFailure('Internal server error');
  factory ServerFailure.timeout() => const ServerFailure('Server timeout');
  factory ServerFailure.maintenance() => const ServerFailure('Server under maintenance');
}

class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure(super.message);

  factory ConnectionFailure.noInternet() => const ConnectionFailure('No internet connection');
  factory ConnectionFailure.timeout() => const ConnectionFailure('Connection timeout');
  factory ConnectionFailure.badCertificate() => const ConnectionFailure('Invalid SSL certificate');
}

/// Authentication related failures
abstract class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.invalidCredentials() => const UnauthorizedFailure('Invalid credentials');
  factory AuthFailure.sessionExpired() => const UnauthorizedFailure('Session has expired');
  factory AuthFailure.requiresLogin() => const UnauthorizedFailure('Login required');
  factory AuthFailure.accountDisabled() => const ForbiddenFailure('Account is disabled');
  factory AuthFailure.accountLocked() => const ForbiddenFailure('Account is locked');
  factory AuthFailure.insufficientPermissions() => const ForbiddenFailure('Insufficient permissions');
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure(super.message);

  factory UnauthorizedFailure.invalidCredentials() => const UnauthorizedFailure('Invalid credentials');
  factory UnauthorizedFailure.sessionExpired() => const UnauthorizedFailure('Session expired');
  factory UnauthorizedFailure.requiresLogin() => const UnauthorizedFailure('Login required');
}

class ForbiddenFailure extends AuthFailure {
    const ForbiddenFailure(super.message);

  factory ForbiddenFailure.insufficientPermissions() => const ForbiddenFailure('Insufficient permissions');
  factory ForbiddenFailure.accountDisabled() => const ForbiddenFailure('Account is disabled');
  factory ForbiddenFailure.accountLocked() => const ForbiddenFailure('Account is locked');
}

/// Data related failures
abstract class DataFailure extends Failure {
  const DataFailure(super.message);
}

class CacheFailure extends DataFailure {
  const CacheFailure(super.message);

  factory CacheFailure.notFound() => const CacheFailure('Data not found in cache');
  factory CacheFailure.invalidData() => const CacheFailure('Invalid data in cache');
  factory CacheFailure.writeError() => const CacheFailure('Failed to write to cache');
}

class ValidationFailure extends DataFailure {
  const ValidationFailure(super.message);

  factory ValidationFailure.invalidFormat() => const ValidationFailure('Invalid data format');
  factory ValidationFailure.missingField() => const ValidationFailure('Required field is missing');
  factory ValidationFailure.invalidValue() => const ValidationFailure('Invalid field value');
}

/// API related failures
abstract class ApiFailure extends Failure {
  const ApiFailure(super.message);
}

class GraphQLFailure extends ApiFailure {
  const GraphQLFailure(super.message);

  factory GraphQLFailure.queryError() => const GraphQLFailure('GraphQL query error');
  factory GraphQLFailure.mutationError() => const GraphQLFailure('GraphQL mutation error');
  factory GraphQLFailure.networkError() => const GraphQLFailure('GraphQL network error');
}

class HttpFailure extends ApiFailure {
  const HttpFailure(super.message);

  factory HttpFailure.badRequest() => const HttpFailure('Bad request');
  factory HttpFailure.notFound() => const HttpFailure('Resource not found');
  factory HttpFailure.serverError() => const HttpFailure('Server error');
}

/// Domain specific failures
class StudentFailure extends Failure {
  const StudentFailure(super.message);
  
  factory StudentFailure.notFound() => const StudentFailure('Student not found');
  factory StudentFailure.invalidData() => const StudentFailure('Invalid student data');
  factory StudentFailure.duplicateEmail() => const StudentFailure('Email already exists');
  factory StudentFailure.invalidGrade() => const StudentFailure('Invalid grade value');
  factory StudentFailure.notEnrolled() => const StudentFailure('Student not enrolled');
}

class FacultyFailure extends Failure {
  const FacultyFailure(super.message);
  
  factory FacultyFailure.notFound() => const FacultyFailure('Faculty not found');
  factory FacultyFailure.invalidData() => const FacultyFailure('Invalid faculty data');
  factory FacultyFailure.duplicateEmail() => const FacultyFailure('Email already exists');
  factory FacultyFailure.notAssigned() => const FacultyFailure('Faculty not assigned');
}

class EnterpriseFailure extends Failure {
  const EnterpriseFailure(super.message);
  
  factory EnterpriseFailure.notFound() => const EnterpriseFailure('Enterprise not found');
  factory EnterpriseFailure.invalidData() => const EnterpriseFailure('Invalid enterprise data');
  factory EnterpriseFailure.duplicateEmail() => const EnterpriseFailure('Email already exists');
  factory EnterpriseFailure.notRegistered() => const EnterpriseFailure('Enterprise not registered');
}
