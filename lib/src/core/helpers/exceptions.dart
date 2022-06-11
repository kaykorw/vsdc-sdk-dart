/// Base type of exception that can be thrown by the `VSDC` package.
abstract class VsdcException implements Exception, Error {
  /// Initializes a new [VsdcException].
  const VsdcException({required this.message, StackTrace? stackTrace})
      : _stackTrace = stackTrace;

  /// The error message.
  final String message;

  final StackTrace? _stackTrace;

  @override
  StackTrace get stackTrace => _stackTrace ?? StackTrace.current;

  @override
  String toString() => '$runtimeType($message)';
}

/// Base exception for exceptions that are thrown due to the status code
/// not being in the accepted range.
///
/// Exception that are thrown by a `404` status code for example, should
/// implement/extend this class.
abstract class Non200StatusCodeException extends VsdcException {
  /// Initializes a new [Non200StatusCodeException]
  const Non200StatusCodeException({
    required super.message,
    required this.statusCode,
    super.stackTrace,
  });

  /// The status code.
  final int statusCode;

  @override
  String toString() => '$runtimeType($statusCode, $message)\n$stackTrace';
}

/// Exception thrown when an http request fails.
class GenericServerException extends VsdcException {
  /// Initializes a new [GenericServerException].
  const GenericServerException({
    super.message = 'The request could not be completed.',
    super.stackTrace,
  });
}

/// Thrown when no credentials were provided to the Vsdc object.
class NoCredentialsProvidedException extends Non200StatusCodeException {
  /// Initializes a new [NoCredentialsProvidedException].
  const NoCredentialsProvidedException({
    super.message = 'No credentials were passed to the Vsdc instance',
    super.stackTrace,
  }) : super(statusCode: 500);
}

/// Thrown when nothing is found on the passed [path].
class NotFoundException extends Non200StatusCodeException {
  /// Initializes a new [NotFoundException].
  const NotFoundException({
    super.message = 'The requested path could not be found.',
    super.stackTrace,
    required this.path,
  }) : super(statusCode: 404);

  /// The path that threw this [NotFoundException].
  final String path;
}

/// Thrown when an authorized request has been sent.
///
/// This could be caused by invalid API credentials or sending a request to a
/// protected route.
class UnauthorizedException extends Non200StatusCodeException {
  /// Initializes a new [UnauthorizedException].
  const UnauthorizedException({super.message = _message, super.stackTrace})
      : super(statusCode: 401);

  static const String _message = 'Could not authorize the request. '
      'Maybe your API credentials are invalid!';
}

/// Thrown when decoding a response body JSON fails.
class JsonDecodeException extends VsdcException {
  /// Initializes a new [JsonDecodeException].
  const JsonDecodeException({
    super.message = 'Failed to decode the response body',
    super.stackTrace,
  });
}

/// Thrown when parsing a decoded response body into a dart object fails.
class JsonDeserializationException extends VsdcException {
  /// Initializes a new [JsonDeserializationException].
  const JsonDeserializationException({
    super.message = 'Failed to parse the body into a model',
    super.stackTrace,
  });
}
