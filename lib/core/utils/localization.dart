import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'fullName': 'Full Name',
      'role': 'Role',
      'student': 'Student',
      'enterprise': 'Enterprise',
      'events': 'Events',
      'createEvent': 'Create Event',
      'editEvent': 'Edit Event',
      'deleteEvent': 'Delete Event',
      'registerForEvent': 'Register for Event',
    },
    'vi': {
      'login': 'Đăng nhập',
      'register': 'Đăng ký',
      'email': 'Email',
      'password': 'Mật khẩu',
      'fullName': 'Họ và tên',
      'role': 'Vai trò',
      'student': 'Sinh viên',
      'enterprise': 'Doanh nghiệp',
      'events': 'Sự kiện',
      'createEvent': 'Tạo sự kiện',
      'editEvent': 'Chỉnh sửa sự kiện',
      'deleteEvent': 'Xóa sự kiện',
      'registerForEvent': 'Đăng ký sự kiện',
    },
  };

  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get role => _localizedValues[locale.languageCode]!['role']!;
  String get student => _localizedValues[locale.languageCode]!['student']!;
  String get enterprise => _localizedValues[locale.languageCode]!['enterprise']!;
  String get events => _localizedValues[locale.languageCode]!['events']!;
  String get createEvent => _localizedValues[locale.languageCode]!['createEvent']!;
  String get editEvent => _localizedValues[locale.languageCode]!['editEvent']!;
  String get deleteEvent => _localizedValues[locale.languageCode]!['deleteEvent']!;
  String get registerForEvent => _localizedValues[locale.languageCode]!['registerForEvent']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}