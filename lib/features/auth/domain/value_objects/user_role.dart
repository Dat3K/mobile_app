enum UserRole {
  faculty,
  student,
  enterprise;

  String get displayName {
    switch (this) {
      case UserRole.faculty:
        return 'Faculty';
      case UserRole.student:
        return 'Student';
      case UserRole.enterprise:
        return 'Enterprise';
    }
  }
}
