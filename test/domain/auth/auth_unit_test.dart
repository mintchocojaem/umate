import 'package:danvery/domain/domain.dart';
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

    test('학생인증 테스트', () async {
      const String dkuStudentId = "dkuStudentId";
      const String dkuPassword = "dkuPassword";

      const Map<String, dynamic> response = {
        "signupToken": "string",
        "student": {
          "studentName": "string",
          "studentId": "string",
          "major": "string"
        }
      };

      when(
        mockDio.post(
          "$developmentBaseUrl/user/dku/verify",
          data: {
            "dkuStudentId": dkuStudentId,
            "dkuPassword": dkuPassword,
          },
        ),
      ).thenAnswer(
        (_) async => Response(
          data: response,
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

      expect(container.read(signUpProvider).value, null);

      // 학생인증
      await container.read(signUpProvider.notifier).verifyStudent(dkuStudentId, dkuPassword);

      expect(container.read(signUpProvider).value, isA<SignUp>());

    });

    test('로그인 테스트', () async {
      const String studentId = "studentId";
      const String password = "password";

      const Map<String, dynamic> response = {
        "accessToken": "accessToken",
        "refreshToken": "refreshToken"
      };

      when(
        mockDio.post(
          "$developmentBaseUrl/user/login",
          data: {
            "studentId": studentId,
            "password": password,
          },
        ),
      ).thenAnswer(
        (_) async => Response(
          data: response,
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
