import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_app/core/network/csrf_interceptor.dart';
import 'package:mobile_app/core/network/dio_client.dart';
import 'package:mobile_app/core/network/http_error.dart';

class MockDio extends Mock implements Dio {}
class MockCsrfInterceptor extends Mock implements CsrfInterceptor {}
class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late DioClient dioClient;
  late MockDio mockDio;
  late MockCsrfInterceptor mockCsrfInterceptor;

  setUp(() {
    mockDio = MockDio();
    mockCsrfInterceptor = MockCsrfInterceptor();

    // Giả lập việc khởi tạo DioClient
    when(() => mockDio.interceptors).thenReturn(Interceptors());
    
    dioClient = DioClient();
    // Inject mock objects vào DioClient
    dioClient
      .._dio = mockDio
      .._csrfInterceptor = mockCsrfInterceptor;
  });

  group('CSRF Token Operations', () {
    test('should successfully refresh CSRF token', () async {
      // Arrange
      const expectedToken = 'new-token';
      when(() => mockCsrfInterceptor.refreshCsrfToken())
          .thenAnswer((_) async => expectedToken);

      // Act
      final result = await dioClient.refreshCsrfToken();

      // Assert
      expect(result, equals(expectedToken));
      verify(() => mockCsrfInterceptor.refreshCsrfToken()).called(1);
    });

    test('should clear CSRF token', () async {
      // Arrange
      when(() => mockCsrfInterceptor.clearCsrfToken())
          .thenAnswer((_) async {});

      // Act
      await dioClient.clearCsrfToken();

      // Assert
      verify(() => mockCsrfInterceptor.clearCsrfToken()).called(1);
    });
  });

  group('HTTP Methods', () {
    const path = '/test';
    final data = {'key': 'value'};

    test('POST request should handle successful response', () async {
      // Arrange
      final mockResponse = MockResponse<Map<String, dynamic>>();
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(data);
      
      when(() => mockDio.post<Map<String, dynamic>>(
            path,
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
          )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await dioClient.post<Map<String, dynamic>>(
        path,
        data: data,
      );

      // Assert
      expect(result, equals(data));
      verify(() => mockDio.post<Map<String, dynamic>>(
            path,
            data: data,
            queryParameters: null,
            options: null,
            cancelToken: null,
          )).called(1);
    });

    test('POST request should handle error response', () async {
      // Arrange
      when(() => mockDio.post<Map<String, dynamic>>(
            path,
            data: any(named: 'data'),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            cancelToken: any(named: 'cancelToken'),
          )).thenThrow(DioException(
            requestOptions: RequestOptions(path: path),
            response: Response(
              statusCode: 400,
              statusMessage: 'Bad Request',
              requestOptions: RequestOptions(path: path),
            ),
          ));

      // Act & Assert
      expect(
        () => dioClient.post<Map<String, dynamic>>(path, data: data),
        throwsA(isA<HttpError>()),
      );
    });
  });
}
