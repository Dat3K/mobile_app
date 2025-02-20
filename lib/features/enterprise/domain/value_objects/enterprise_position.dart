enum EnterprisePosition {
  admin,
  manager,
  coordinator,
  staff;

  String get displayName {
    switch (this) {
      case EnterprisePosition.admin:
        return 'Administrator';
      case EnterprisePosition.manager:
        return 'Manager';
      case EnterprisePosition.coordinator:
        return 'Coordinator';
      case EnterprisePosition.staff:
        return 'Staff';
    }
  }

  bool get isAdmin => this == EnterprisePosition.admin;
  bool get isManager => this == EnterprisePosition.manager;
  bool get isCoordinator => this == EnterprisePosition.coordinator;
  bool get isStaff => this == EnterprisePosition.staff;
  bool get canManageUsers => this == EnterprisePosition.admin || this == EnterprisePosition.manager;
  bool get canCreateEvents => this != EnterprisePosition.staff;
  bool get canEditEnterpriseProfile => this == EnterprisePosition.admin;
} 