import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_app/core/network/csrf_interceptor.dart';

class MockDio extends Mock implements Dio {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockRequestOptions extends Mock implements RequestOptions {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockResponse extends Mock implements Response {}

void main() {
  late CsrfInterceptor interceptor;
  late MockDio mockDio;
  late MockFlutterSecureStorage mockStorage;
  late MockRequestOptions mockOptions;
  late MockRequestInterceptorHandler mockHandler;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockFlutterSecureStorage();
    mockOptions = MockRequestOptions();
    mockHandler = MockRequestInterceptorHandler();

    interceptor = CsrfInterceptor(
      dio: mockDio,
      storage: mockStorage,
    );

    // Mặc định cho RequestOptions
    when(() => mockOptions.method).thenReturn('POST');
    when(() => mockOptions.headers).thenReturn({});
  });

  group('onRequest', () {
    test('should skip CSRF token for GET requests', () async {
      // Arrange
      when(() => mockOptions.method).thenReturn('GET');

      // Act
      await interceptor.onRequest(mockOptions, mockHandler);

      // Assert
      verify(() => mockHandler.next(mockOptions)).called(1);
      verifyNever(() => mockStorage.read(key: any(named: 'key')));
    });

    test('should add existing CSRF token to header', () async {
      // Arrange
      const token = 'existing-token';
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => token);

      // Act
      await interceptor.onRequest(mockOptions, mockHandler);

      // Assert
      verify(() => mockOptions.headers['X-CSRF-TOKEN'] = token).called(1);
      verify(() => mockHandler.next(mockOptions)).called(1);
    });

    test('should refresh token if none exists', () async {
      // Arrange
      const newToken = 'new-token';
      final mockResponse = MockResponse();
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(() => mockDio.get('/csrf-token'))
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.headers).thenReturn(
        Headers.fromMap({
          'set-cookie': ['XSRF-TOKEN=$newToken; path=/']
        }),
      );
      when(() => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenAnswer((_) async {});

      // Act
      await interceptor.onRequest(mockOptions, mockHandler);

      // Assert
      verify(() => mockDio.get('/csrf-token')).called(1);
      verify(() => mockStorage.write(
            key: any(named: 'key'),
            value: newToken,
          )).called(1);
      verify(() => mockOptions.headers['X-CSRF-TOKEN'] = newToken).called(1);
      verify(() => mockHandler.next(mockOptions)).called(1);
    });

    test('should handle error when refreshing token fails', () async {
      // Arrange
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(() => mockDio.get('/csrf-token'))
          .thenThrow(Exception('Network error'));

      // Act
      await interceptor.onRequest(mockOptions, mockHandler);

      // Assert
      verify(() => mockHandler.reject(any())).called(1);
    });
  });

  group('refreshCsrfToken', () {
    test('should successfully refresh token', () async {
      // Arrange
      const newToken = 'new-token';
      final mockResponse = MockResponse();
      when(() => mockDio.get('/csrf-token'))
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.headers).thenReturn(
        Headers.fromMap({
          'set-cookie': ['XSRF-TOKEN=$newToken; path=/']
        }),
      );
      when(() => mockStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenAnswer((_) async {});

      // Act
      final result = await interceptor.refreshCsrfToken();

      // Assert
      expect(result, equals(newToken));
      verify(() => mockStorage.write(
            key: any(named: 'key'),
            value: newToken,
          )).called(1);
    });

    test('should throw exception when token not found in response', () async {
      // Arrange
      final mockResponse = MockResponse();
      when(() => mockDio.get('/csrf-token'))
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.headers).thenReturn(Headers());

      // Act & Assert
      expect(
        () => interceptor.refreshCsrfToken(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('clearCsrfToken', () {
    test('should clear stored token', () async {
      // Arrange
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      // Act
      await interceptor.clearCsrfToken();

      // Assert
      verify(() => mockStorage.delete(key: any(named: 'key'))).called(1);
    });
  });
}
