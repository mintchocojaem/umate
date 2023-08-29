import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/utils/api_constants.dart';
import 'package:danvery/utils/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../dio.mocks.dart';

class Listener<T> extends Mock {
  void call(T? previous, T? current);
}

@GenerateMocks([Dio])
void main() {
  group('Auth Test', () {
    late Dio mockDio;

    setUpAll(() {
      mockDio = MockDio();

      when(mockDio.options).thenReturn(
        BaseOptions(baseUrl: developmentBaseUrl),
      );
    });

    test('로그인 테스트 : Token', () async {
      const String studentId = "studentId";
      const String password = "password";

      const Map<String, dynamic> responseToken = {
        'accessToken': "accessToken",
        'refreshToken': 'refreshToken'
      };

      when(
        mockDio.post(
          '$developmentBaseUrl/user/login',
          data: {
            'studentId': studentId,
            'password': password,
          },
        ),
      ).thenAnswer(
        (_) async => Response(
          data: responseToken,
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final container = ProviderContainer(
        overrides: [
          dioProvider.overrideWithValue(mockDio),
        ],
      );
      addTearDown(() => container.dispose());

      expect(container.read(tokenProvider).value, null);

      // 로그인
      await container.read(tokenProvider.notifier).login(studentId, password);

      expect(container.read(tokenProvider).value, isA<Token>());

    });
  });
}
