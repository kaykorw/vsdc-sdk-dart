/// An interface that holds the required parameters for a request.
abstract class RequestOptions {
  /// Initializes a new [RequestOptions]
  const RequestOptions({this.query});

  /// Query parameters of the request.
  final Map<String, dynamic>? query;
}

/// An implementation of [RequestOptions] for `GET` requests.
class GetOptions extends RequestOptions {
  /// Initializes a new [GetOptions]
  const GetOptions({super.query, this.accessToken});

  /// Access token.
  final String? accessToken;
}

/// An implementation of [RequestOptions] for `POST` request
class PostOptions extends RequestOptions {
  /// Initializes a new [PostOptions].
  const PostOptions({super.query, this.idempotencyKey});

  ///
  final String? idempotencyKey;
}

/// An implementation of [RequestOptions] for  `PUT`.
class PutOptions extends PostOptions {
  /// Initializes a new [PutOptions].
  const PutOptions({super.idempotencyKey, super.query});
}
