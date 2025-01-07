/// Contains all the route paths used in the application
class AppRoutes {
  AppRoutes._(); // Private constructor to prevent instantiation

  // Auth Routes
  static const String initial = '/';
  static const String login = '/login';
  static const String register = '/register';

  // Faculty Routes
  static const String faculty = '/faculty';
  static const String facultyClasses = '$faculty/classes';
  static const String facultyAssignments = '$faculty/assignments';
  static const String facultyStudents = '$faculty/students';
  static const String facultySchedule = '$faculty/schedule';

  // Student Routes
  static const String student = '/student';
  static const String studentCourses = '$student/courses';
  static const String studentAssignments = '$student/assignments';
  static const String studentGrades = '$student/grades';
  static const String studentEvents = '$student/events';

  // Enterprise Routes
  static const String enterprise = '/enterprise';
  static const String enterpriseJobs = '$enterprise/jobs';
  static const String enterpriseApplicants = '$enterprise/applicants';
  static const String enterpriseProfile = '$enterprise/profile';
  static const String enterpriseAnalytics = '$enterprise/analytics';
}
