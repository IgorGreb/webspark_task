import 'package:flutter_test/flutter_test.dart';
import 'package:webspark_task/core/validators/url_validator.dart';

void main() {
  group('UrlValidator.validate (format)', () {
    test('accepts public https url', () {
      expect(
        UrlValidator.isValid('https://flutter.webspark.dev/flutter/api'),
        isTrue,
      );
    });

    test('rejects empty, long, credentialed and non-http urls', () {
      expect(UrlValidator.isValid(''), isFalse);
      expect(UrlValidator.isValid('ftp://example.com'), isFalse);
      expect(UrlValidator.isValid('not a url'), isFalse);
      expect(
        UrlValidator.isValid('https://user:pass@example.com/'),
        isFalse,
      );
      expect(UrlValidator.isValid('http://[invalid'), isFalse);
      expect(
        UrlValidator.isValid('https://example.com/${'a' * 2100}'),
        isFalse,
      );
    });
  });

  group('UrlValidator.isSafeForRequest (SSRF)', () {
    test('allows public hosts', () {
      expect(
        UrlValidator.isSafeForRequest('https://flutter.webspark.dev/x'),
        isTrue,
      );
      expect(UrlValidator.isSafeForRequest('http://example.com/'), isTrue);
    });

    test('blocks localhost / loopback / private ranges / metadata', () {
      for (final url in [
        'http://localhost/api',
        'http://localhost.localdomain/',
        'http://127.0.0.1/',
        'http://10.0.0.5/',
        'http://192.168.1.1/',
        'http://172.16.0.2/',
        'http://172.31.255.1/',
        'http://169.254.169.254/latest/meta-data/',
        'http://0.0.0.0/',
        'http://[::1]/',
        'http://[fe80::1]/',
        'http://metadata.google.internal/',
        'http://printer.local/',
        'http://intranet/',
      ]) {
        expect(UrlValidator.isSafeForRequest(url), isFalse, reason: url);
      }
    });

    test('does not block public lookalikes of private ranges', () {
      expect(
        UrlValidator.isSafeForRequest('https://172.32.0.1/'),
        isTrue,
      );
      expect(
        UrlValidator.isSafeForRequest('https://192.169.1.1/'),
        isTrue,
      );
    });
  });

  group('UrlValidator.isPlainHttp', () {
    test('flags cleartext urls', () {
      expect(UrlValidator.isPlainHttp('http://example.com/'), isTrue);
      expect(UrlValidator.isPlainHttp('https://example.com/'), isFalse);
      expect(UrlValidator.isPlainHttp('not a url'), isFalse);
    });
  });
}
