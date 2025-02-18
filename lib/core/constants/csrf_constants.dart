class CsrfConstants {
  static const String csrfHeaderKey = 'X-XSRF-TOKEN';
  static const String csrfEndpoint = '/csrf-token';
  static const String invalidCsrfMessage = 'Invalid_CsrfToken';
  static const String invalidCookieMessage = 'Invalid_CsrfCookie';
  static const int maxRetries = 3;
  static const String cookieName = 'XSRF-TOKEN';
} 