import 'dart:io' show HttpDate, HttpException, SocketException;

/// IO implementation that parses HTTP dates using [HttpDate.parse].
///
/// Supports all RFC 7231 date formats:
/// - RFC 1123 (preferred): "Wed, 21 Oct 2015 07:28:00 GMT"
/// - RFC 850: "Wednesday, 21-Oct-15 07:28:00 GMT"
/// - ANSI C asctime(): "Wed Oct 21 07:28:00 2015"
DateTime parseHttpDate(String value) {
  try {
    return HttpDate.parse(value);
  } on RangeError {
    // Dart 3.6's HttpDate parser leaks RangeError for truncated input. Preserve
    // the invalid-date HttpException contract of the upstream Dart toolchain.
    throw HttpException('Invalid HTTP date: $value');
  }
}

/// IO implementation that checks if an error is a [SocketException].
bool isSocketException(Object error) => error is SocketException;
