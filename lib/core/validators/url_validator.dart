abstract class UrlValidator {
  static String? validate(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return 'empty';
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return 'invalid';
    if (uri.scheme != 'http' && uri.scheme != 'https') return 'invalid';
    return null;
  }

  static bool isValid(String? value) => validate(value) == null;
}
