enum UserRole {
  student,
  enterprise;

  String get displayName {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.enterprise:
        return 'Enterprise';
    }
  }

  bool get isStudent => this == UserRole.student;
  bool get isEnterprise => this == UserRole.enterprise;
} 