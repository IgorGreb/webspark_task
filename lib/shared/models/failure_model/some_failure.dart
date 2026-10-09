import 'package:flutter/widgets.dart';
import 'package:webspark_task/l10n/l10n.dart';

enum SomeFailure {
  invalidUrl,
  network,
  serverError,
  tooManyRequests,
  dataNotFound,
  format,
  timeout,
  cancelled,
  unauthorized,
  unknown;

  String get message {
    switch (this) {
      case SomeFailure.invalidUrl:
        return 'Invalid URL. Please enter a valid API base URL.';
      case SomeFailure.network:
        return 'Network error. Check your connection and try again.';
      case SomeFailure.serverError:
        return 'Server error. Please try again later.';
      case SomeFailure.tooManyRequests:
        return 'Too many requests. Please wait and try again.';
      case SomeFailure.dataNotFound:
        return 'Data not found.';
      case SomeFailure.format:
        return 'Invalid response format.';
      case SomeFailure.timeout:
        return 'Request timed out. Please try again.';
      case SomeFailure.cancelled:
        return 'Request was cancelled.';
      case SomeFailure.unauthorized:
        return 'Unauthorized request.';
      case SomeFailure.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  String localizedMessage(BuildContext? context) {
    final l10n = context?.maybeL10n;
    if (l10n == null) return message;
    switch (this) {
      case SomeFailure.invalidUrl:
        return l10n.invalidUrlFailure;
      case SomeFailure.network:
        return l10n.networkFailure;
      case SomeFailure.serverError:
        return l10n.serverErrorFailure;
      case SomeFailure.tooManyRequests:
        return l10n.tooManyRequestsFailure;
      case SomeFailure.dataNotFound:
        return l10n.dataNotFoundFailure;
      case SomeFailure.format:
        return l10n.formatFailure;
      case SomeFailure.timeout:
        return l10n.timeoutFailure;
      case SomeFailure.cancelled:
        return l10n.cancelledFailure;
      case SomeFailure.unauthorized:
        return l10n.unauthorizedFailure;
      case SomeFailure.unknown:
        return l10n.unknownFailure;
    }
  }
}
