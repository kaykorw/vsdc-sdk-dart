/// An extension on [DateTime].
extension DateTimeX on DateTime {
  /// Parses this [DateTime] to a `YYYYMMDDHHiiSS` string format.
  String toVsdcFormat() {
    final parsed =
        toString().replaceAll('-', '').replaceAll(':', '').replaceAll(
              ' ',
              '',
            );
    return parsed.substring(0, 14);
  }
}
