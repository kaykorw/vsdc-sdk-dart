import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vsdc/src/core/helpers/exceptions.dart';
import 'package:vsdc/src/core/helpers/request_options.dart';

part 'options.dart';

/// Lowest API client that sends requests to the server
///
/// This class should not be available to the public library. There should be
/// a higher class that will be availble to the library and will be
/// communicating with a [VsdcClient] object.
class VsdcClient {
  /// Initializes a new [VsdcClient] object.
  VsdcClient({required this.options, http.Client? client})
      : _client = client ?? http.Client();

  /// Required options.
  final VsdcOptions options;

  final http.Client _client;

  /// Makes a `GET` request to the [path].
  ///
  /// This method returns the decoded JSON body as a [dynamic]. It's recommended
  /// to apply casting when assiging the value to a variable.
  ///
  /// Example:
  /// ```dart
  /// Future<void> main() async {
  ///   final options = VsdcOptions(
  ///      deviceSerialNumber: '12345XYZ',
  ///      environment: const VsdcEnvironment(
  ///      hostName: 'example.com',
  ///      isProduction: false,
  ///      ),
  ///      lastRequestTime: DateTime.now(),
  ///      tin: 'XX456Z',
  ///   );
  ///
  ///   final vsdc = VsdcClient(options:options);
  ///
  /// // Because we expect the data as a Map<String, dynamic> we have to had type casting.
  ///   final data = await vsdc.get(
  ///          path: '/example',
  ///          options: GetOptions(accessToken:'test')),
  ///       ) as Map<String, dynamic>;
  ///
  ///   print(data);
  /// }
  /// ```
  Future<dynamic> get({
    required GetOptions options,
    required String path,
  }) async {
    final uri = Uri.https(
      this.options.environment.hostName,
      path,
      options.query,
    );
    late final http.Response response;

    try {
      response = await _client.get(
        uri,
        headers: {'Authorization': 'Bearer ${options.accessToken}'},
      );
    } catch (e) {
      throw const GenericServerException();
    }

    _checkStatusCode(response.statusCode, path);
    return _decodeJsonBody(response.body);
  }

  /// Makes a `POST` request at the passed [path] to the VSDC server.
  ///
  /// This method returns the decoded JSON body as a [dynamic]. It's recommended
  /// to apply casting when assiging the value to a variable.
  ///
  /// Example:
  /// ```dart
  /// Future<void> main() async {
  ///   final options = VsdcOptions(
  ///      deviceSerialNumber: '12345XYZ',
  ///      environment: const VsdcEnvironment(
  ///      hostName: 'example.com',
  ///      isProduction: false,
  ///      ),
  ///      lastRequestTime: DateTime.now(),
  ///      tin: 'XX456Z',
  ///   );
  ///
  ///   final vsdc = VsdcClient(options:options);
  ///
  /// // Because we expect the data as a Map<String, dynamic> we have to had type casting.
  ///   final data = await vsdc.post(
  ///          path: '/example',
  ///          options: PostOptions(idempotencyKey:'test')),
  ///       ) as Map<String, dynamic>;
  ///
  ///   print(data);
  /// }
  /// ```
  Future<dynamic> post({
    required PostOptions options,
    required String path,
    required Map<String, dynamic> body,
  }) async {
    final uri = Uri.https(
      this.options.environment.hostName,
      path,
      options.query,
    );

    late final http.Response response;

    try {
      response = await _client.post(
        uri,
        body: body,
        headers: options.idempotencyKey != null
            ? {'Idempotency-Key': options.idempotencyKey!}
            : null,
      );
    } catch (e) {
      throw const GenericServerException();
    }
    _checkStatusCode(response.statusCode, path);
    return _decodeJsonBody(response.body);
  }

  /// Makes a `PUT` request to the `Vsdc` server on the passed [path].
  /// This method returns the decoded JSON body as a [dynamic]. It's recommended
  /// to apply casting when assiging the value to a variable.
  ///
  /// Example:
  /// ```dart
  /// Future<void> main() async {
  ///   final options = VsdcOptions(
  ///      deviceSerialNumber: '12345XYZ',
  ///      environment: const VsdcEnvironment(
  ///      hostName: 'example.com',
  ///      isProduction: false,
  ///      ),
  ///      lastRequestTime: DateTime.now(),
  ///      tin: 'XX456Z',
  ///   );
  ///
  ///   final vsdc = VsdcClient(options:options);
  ///
  /// // Because we expect the data as a Map<String, dynamic> we have to had type casting.
  ///   final data = await vsdc.put(
  ///          path: '/example',
  ///          options: PutOptions(idempotencyKey:'test')),
  ///       ) as Map<String, dynamic>;
  ///
  ///   print(data);
  /// }
  /// ```
  Future<dynamic> put({
    required PutOptions options,
    required String path,
    required Map<String, dynamic> body,
  }) async {
    late final uri = Uri.https(
      this.options.environment.hostName,
      path,
      options.query,
    );

    late final http.Response response;

    try {
      response = await _client.put(
        uri,
        body: body,
        headers: options.idempotencyKey != null
            ? {'Idempotency-Key': options.idempotencyKey!}
            : null,
      );
    } catch (e, s) {
      throw GenericServerException(stackTrace: s);
    }

    _checkStatusCode(response.statusCode, path);
    return _decodeJsonBody(response.body);
  }

  /// Checks the status code of the request and throws the correct
  /// exception if the status code is not positive.
  void _checkStatusCode(int statusCode, String path) {
    if (statusCode < 200 || statusCode >= 300) {
      switch (statusCode) {
        case 401:
          throw const UnauthorizedException();
        case 404:
          throw NotFoundException(path: path);
        default:
          throw const GenericServerException();
      }
    }
  }

  dynamic _decodeJsonBody(String encoded) {
    try {
      return json.decode(encoded);
    } catch (e, s) {
      throw JsonDecodeException(stackTrace: s, message: '$e');
    }
  }
}
