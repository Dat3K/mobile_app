import 'package:flutter/foundation.dart';
import 'package:mobile_app/features/auth/domain/value_objects/user_role.dart';

@immutable
class RouterState {
  final String? redirectPath;
  final bool isLoading;

  const RouterState({
    this.redirectPath,
    this.isLoading = false,
  });

  RouterState copyWith({
    String? redirectPath,
    bool? isLoading,
  }) {
    return RouterState(
      redirectPath: redirectPath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

enum RouteLocation {
  login,
  student,
  enterprise,
  unknown;

  static RouteLocation fromPath(String path) {
    if (path.startsWith('/login')) return RouteLocation.login;
    if (path.startsWith('/student')) return RouteLocation.student;
    if (path.startsWith('/enterprise')) return RouteLocation.enterprise;
    return RouteLocation.unknown;
  }

  bool get isProtected => this != RouteLocation.login;
  
  bool isAuthorizedFor(UserRole? role) {
    if (!isProtected) return true;
    
    return switch (this) {
      RouteLocation.student => role == UserRole.student,
      RouteLocation.enterprise => role == UserRole.enterprise,
      _ => false,
    };
  }
}
