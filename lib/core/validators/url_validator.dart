/// URL validation + SSRF hardening.
/// [validate] keeps the UX-level format check (scheme + host).
/// [isSafeForRequest] additionally blocks non-routable targets
/// (localhost / LAN / cloud metadata) so the app never fetches them.
abstract class UrlValidator {
  static const int maxUrlLength = 2048;

  static String? validate(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return 'empty';
    if (trimmed.length > maxUrlLength) return 'invalid';
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return 'invalid';
    if (uri.scheme != 'http' && uri.scheme != 'https') return 'invalid';
    // Reject embedded credentials like https://user:pass@host/.
    if (uri.userInfo.isNotEmpty) return 'invalid';
    return null;
  }

  static bool isValid(String? value) => validate(value) == null;

  /// True when the URL is well-formed AND points at a public host.
  static bool isSafeForRequest(String? value) {
    if (!isValid(value)) return false;
    final host = Uri.tryParse(value!.trim())?.host ?? '';
    return !isBlockedHost(host);
  }

  static bool isBlockedHost(String host) {
    final h = host.trim().toLowerCase();
    if (h.isEmpty) return true;
    // Strip trailing dot (FQDN root) and brackets for IPv6 literals.
    final normalized = h.endsWith('.') ? h.substring(0, h.length - 1) : h;
    final bare = normalized.startsWith('[') && normalized.endsWith(']')
        ? normalized.substring(1, normalized.length - 1)
        : normalized;

    if (bare == 'localhost' || bare == 'localhost.localdomain') return true;
    if (bare == '::1' || bare == '0.0.0.0') return true;
    // IPv4 literal checks.
    final v4 = RegExp(r'^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$')
        .firstMatch(bare);
    if (v4 != null) {
      final o = <int>[
        int.parse(v4.group(1)!),
        int.parse(v4.group(2)!),
        int.parse(v4.group(3)!),
        int.parse(v4.group(4)!),
      ];
      if (o.any((e) => e > 255)) return true;
      if (o[0] == 10) return true; // 10/8
      if (o[0] == 127) return true; // loopback
      if (o[0] == 169 && o[1] == 254) return true; // link-local / cloud metadata
      if (o[0] == 192 && o[1] == 168) return true; // 192.168/16
      if (o[0] == 172 && o[1] >= 16 && o[1] <= 31) return true; // 172.16/12
      if (o[0] == 0 || o[0] >= 224) return true; // 0/8, multicast, reserved
    }
    // Link-local / loopback IPv6.
    if (bare.startsWith('fe80:') ||
        bare.startsWith('fec0:') ||
        bare.startsWith('fc00:') ||
        bare.startsWith('fd00:')) {
      return true;
    }
    // Metadata / internal hostnames.
    if (bare == 'metadata.google.internal' ||
        bare == 'intranet' ||
        bare.endsWith('.internal') ||
        bare.endsWith('.local') ||
        bare.endsWith('.localhost') ||
        bare.endsWith('.intranet') ||
        bare.endsWith('.lan')) {
      return true;
    }
    return false;
  }

  static bool isPlainHttp(String? value) {
    final uri = Uri.tryParse((value ?? '').trim());
    return uri?.scheme == 'http';
  }
}
