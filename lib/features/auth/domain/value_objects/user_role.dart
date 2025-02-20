enum UserRole {
  student,
  faculty,
  enterprise;

  String get displayName {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.faculty:
        return 'Faculty';
      case UserRole.enterprise:
        return 'Enterprise';
    }
  }

  bool get isStudent => this == UserRole.student;
  bool get isFaculty => this == UserRole.faculty;
  bool get isEnterprise => this == UserRole.enterprise;
} 