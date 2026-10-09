// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeScreenTitle => 'Home screen';

  @override
  String get startCountingProcess => 'Start counting process';

  @override
  String get notFoundTitle => 'Page not found';

  @override
  String get notFoundMessage => 'The page you requested does not exist.';

  @override
  String get notFoundGoHome => 'Go home';

  @override
  String get setValidBaseUrl => 'Set valid API base URL in order to continue';

  @override
  String get baseUrlHint => 'https://example.com';

  @override
  String get processScreenTitle => 'Process screen';

  @override
  String get calculationsInProgress => 'Calculating shortest paths...';

  @override
  String get calculationsFinished =>
      'All calculations has finished, you can send your results to server';

  @override
  String get sendResultsToServer => 'Send results to server';

  @override
  String get sendingResults => 'Sending results...';

  @override
  String get resultScreenTitle => 'Result list screen';

  @override
  String get emptyResultsMessage => 'No results available.';

  @override
  String get previewScreenTitle => 'Preview screen';

  @override
  String get previewEmptyMessage => 'No task selected.';

  @override
  String previewPathLengthLabel(int length) {
    return 'Path length: $length';
  }

  @override
  String get tryAgain => 'Try Again';

  @override
  String get invalidUrlFailure =>
      'Invalid URL. Please enter a valid API base URL.';

  @override
  String get networkFailure =>
      'Network error. Check your connection and try again.';

  @override
  String get serverErrorFailure => 'Server error. Please try again later.';

  @override
  String get tooManyRequestsFailure =>
      'Too many requests. Please wait and try again.';

  @override
  String get dataNotFoundFailure => 'Data not found.';

  @override
  String get formatFailure => 'Invalid response format.';

  @override
  String get timeoutFailure => 'Request timed out. Please try again.';

  @override
  String get cancelledFailure => 'Request was cancelled.';

  @override
  String get unauthorizedFailure => 'Unauthorized request.';

  @override
  String get unknownFailure => 'Something went wrong. Please try again.';

  @override
  String get insecureHttpWarning =>
      'Unencrypted http:// connection — results are sent in cleartext.';
}
