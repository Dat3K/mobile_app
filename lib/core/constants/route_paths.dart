/// Contains all the route paths used in the application
class RoutePaths {
  RoutePaths._(); // Private constructor to prevent instantiation

  // Auth Routes
  static const String login = '/login';
  static const String register = '/register';

  // Student Routes
  static const String student = '/student';
  static const String studentRegister = '$student/register';
  static const String studentNotifications = '$student/notifications';
  static const String studentProfile = '$student/profile';
  static const String studentList = '$student/list';
  static const String studentPaginatedList = '$student/paginated-list';
  static const String studentForm = '$student/form';
  static const String studentEdit = '$student/edit';

  // Enterprise Routes
  static const String enterprise = '/enterprise';
  static const String enterpriseEvents = '$enterprise/events';
  static const String enterpriseApplicants = '$enterprise/applicants';
  static const String enterpriseProfile = '$enterprise/profile';
}