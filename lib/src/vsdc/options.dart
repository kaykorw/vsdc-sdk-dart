part of 'vsdc_client.dart';

/// A class that holds the required paramters for a [VsdcClient] object.
@immutable
class VsdcOptions {
  /// Initializes a new [VsdcOptions].
  const VsdcOptions({
    required this.deviceSerialNumber,
    required this.environment,
    required this.lastRequestTime,
    required this.tin,
    this.branchId = '00',
  });

  /// The environment.
  final VsdcEnvironment environment;

  /// TIN number of the business
  final String tin;

  /// The ID of the business's branch.
  final String branchId;

  /// The serial number of the device that's making the request.
  final String deviceSerialNumber;

  /// The time when the last [VsdcClient] request was made.
  final DateTime lastRequestTime;

  @override
  int get hashCode => Object.hashAll(
        [
          environment,
          tin,
          branchId,
          deviceSerialNumber,
          lastRequestTime,
        ],
      );

  @override
  bool operator ==(covariant Object other) =>
      other is VsdcOptions &&
      tin == other.tin &&
      environment == other.environment &&
      branchId == other.branchId &&
      deviceSerialNumber == other.deviceSerialNumber &&
      lastRequestTime == other.lastRequestTime;
}

/// The environment in which an instance of [VsdcClient] should run.
class VsdcEnvironment {
  /// Initializes a new [VsdcEnvironment].
  const VsdcEnvironment({required this.hostName, required this.isProduction});

  /// The host name where the `VSDC` server is hosted.
  final String hostName;

  /// Whether or not this is a production environment.
  final bool isProduction;
}
