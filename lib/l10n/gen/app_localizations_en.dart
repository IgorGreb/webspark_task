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
  String get calculationsFinished =>
      'All calculations has finished, you can send your results to server';

  @override
  String get calculationsInProgress => 'Calculating shortest paths...';

  @override
  String get sendResultsToServer => 'Send results to server';
}
