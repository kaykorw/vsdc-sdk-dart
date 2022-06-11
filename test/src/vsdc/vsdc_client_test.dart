import 'dart:convert';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vsdc/src/core/helpers/exceptions.dart';
import 'package:vsdc/src/core/helpers/request_options.dart';
import 'package:vsdc/src/vsdc/vsdc_client.dart';

class MockClient extends Mock implements Client {}

class FakeData extends Fake implements Map<String, dynamic> {}

void main() {
  late final Client client;
  late final VsdcClient subject;

  const getOptions = GetOptions();
  const postOptions = PostOptions();
  const putOptions = PutOptions();

  final data = {'example': 'test'};
  final encoded = json.encode(data);
  final uri = Uri();

  final options = VsdcOptions(
    deviceSerialNumber: 'DEVICE SERIAL NUMBER',
    environment: const VsdcEnvironment(
      hostName: 'example.com',
      isProduction: false,
    ),
    lastRequestTime: DateTime.now(),
    tin: 'TIN NUMBER',
  );
  group('[VsdcClient]', () {
    setUpAll(() {
      client = MockClient();
      subject = VsdcClient(options: options, client: client);

      registerFallbackValue(uri);

      when(
        () => client.get(
          any<Uri>(),
          headers: any<Map<String, String>>(named: 'headers'),
        ),
      ).thenAnswer(
        (_) => Future<Response>.value(Response(encoded, 200)),
      );

      when(
        () => client.post(
          any<Uri>(),
          headers: any<Map<String, String>>(named: 'headers'),
          body: any<Map<String, dynamic>>(named: 'body'),
        ),
      ).thenAnswer(
        (_) => Future<Response>.value(Response(encoded, 200)),
      );

      when(
        () => client.put(
          any<Uri>(),
          headers: any<Map<String, String>>(named: 'headers'),
          body: any<Map<String, dynamic>>(named: 'body'),
        ),
      ).thenAnswer(
        (_) => Future<Response>.value(Response(encoded, 200)),
      );
    });

    group('get', () {
      test(
        'should make a `GET` request to the hostname and return the data',
        () {
          expectLater(
            subject.get(options: getOptions, path: '/example'),
            completion(data),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the request fails',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenThrow(Exception());

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$UnauthorizedException] when the status code is 401',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 401)));

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<UnauthorizedException>()),
          );
        },
      );

      test(
        'should throw a [$NotFoundException] when the status code is 404',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 404)));

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the status code is '
        'lower than 200 or higher than 299 but neither a '
        '[$UnauthorizedException] nor a [$NotFoundException]',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 500)));

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$JsonDecodeException] if decoding the json fails',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer(
            (_) => Future<Response>.value(Response('encoded', 200)),
          );

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );
    });

    group('post', () {
      test(
        'should make a `POST` request to the hostname and return the data',
        () {
          expectLater(
            subject.post(options: postOptions, path: '/test', body: data),
            completion(data),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the request fails',
        () {
          when(
            () => client.post(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenThrow(Exception());

          expect(
            subject.post(options: postOptions, path: '/example', body: data),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$UnauthorizedException] when the status code is 401',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 401)));

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<UnauthorizedException>()),
          );
        },
      );

      test(
        'should throw a [$NotFoundException] when the status code is 404',
        () {
          when(
            () => client.get(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 404)));

          expect(
            subject.get(options: getOptions, path: '/example'),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the status code is '
        'lower than 200 or higher than 299 but neither a '
        '[$UnauthorizedException] nor a [$NotFoundException]',
        () {
          when(
            () => client.post(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 500)));

          expect(
            subject.post(options: postOptions, path: '/example', body: data),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$JsonDecodeException] if decoding the json fails',
        () {
          when(
            () => client.post(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer(
            (_) => Future<Response>.value(Response('encoded', 200)),
          );

          expect(
            subject.post(options: postOptions, path: '/example', body: data),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );
    });

    group('put', () {
      test(
        'should make a `GET` request to the hostname and return the data',
        () {
          expectLater(
            subject.put(options: putOptions, path: '/example', body: data),
            completion(data),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the request fails',
        () {
          when(
            () => client.put(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenThrow(Exception());

          expect(
            subject.put(options: putOptions, path: '/example', body: data),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$UnauthorizedException] when the status code is 401',
        () {
          when(
            () => client.put(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 401)));

          expect(
            subject.put(options: putOptions, path: '/example', body: data),
            throwsA(isA<UnauthorizedException>()),
          );
        },
      );

      test(
        'should throw a [$NotFoundException] when the status code is 404',
        () {
          when(
            () => client.put(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 404)));

          expect(
            subject.put(options: putOptions, path: '/example', body: data),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      test(
        'should throw a [$GenericServerException] when the status code is '
        'lower than 200 or higher than 299 but neither a '
        '[$UnauthorizedException] nor a [$NotFoundException]',
        () {
          when(
            () => client.put(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer((_) => Future<Response>.value(Response(encoded, 500)));

          expect(
            subject.put(options: putOptions, path: '/example', body: data),
            throwsA(isA<GenericServerException>()),
          );
        },
      );

      test(
        'should throw a [$JsonDecodeException] if decoding the json fails',
        () {
          when(
            () => client.put(
              any<Uri>(),
              headers: any<Map<String, String>>(named: 'headers'),
              body: data,
            ),
          ).thenAnswer(
            (_) => Future<Response>.value(Response('encoded', 200)),
          );

          expect(
            subject.put(options: putOptions, path: '/example', body: data),
            throwsA(isA<JsonDecodeException>()),
          );
        },
      );
    });
  });
}
