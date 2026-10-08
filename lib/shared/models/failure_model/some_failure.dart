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
}
