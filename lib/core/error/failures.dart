import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
} 

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class CancelFailure extends Failure {
  const CancelFailure(super.message);
}

class BadResponseFailure extends Failure {
  const BadResponseFailure(super.message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

class BadCertificateFailure extends Failure {
  const BadCertificateFailure(super.message);
}