import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Title of the Home screen app bar
  ///
  /// In en, this message translates to:
  /// **'Home screen'**
  String get homeScreenTitle;

  /// Label of the button starting the counting process on Home screen
  ///
  /// In en, this message translates to:
  /// **'Start counting process'**
  String get startCountingProcess;

  /// Title of the not found screen app bar
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get notFoundTitle;

  /// Message shown on the not found screen
  ///
  /// In en, this message translates to:
  /// **'The page you requested does not exist.'**
  String get notFoundMessage;

  /// Label of the button returning to home from not found screen
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get notFoundGoHome;

  /// Hint text on Home screen asking for valid API base URL
  ///
  /// In en, this message translates to:
  /// **'Set valid API base URL in order to continue'**
  String get setValidBaseUrl;

  /// Placeholder for API base URL input on Home screen
  ///
  /// In en, this message translates to:
  /// **'https://example.com'**
  String get baseUrlHint;

  /// Title of the Process screen app bar
  ///
  /// In en, this message translates to:
  /// **'Process screen'**
  String get processScreenTitle;

  /// Message shown while calculations are in progress on Process screen
  ///
  /// In en, this message translates to:
  /// **'Calculating shortest paths...'**
  String get calculationsInProgress;

  /// Message shown when all calculations are finished on Process screen
  ///
  /// In en, this message translates to:
  /// **'All calculations has finished, you can send your results to server'**
  String get calculationsFinished;

  /// Label of the button sending results to server on Process screen
  ///
  /// In en, this message translates to:
  /// **'Send results to server'**
  String get sendResultsToServer;

  /// Message shown while results are being sent on Process screen
  ///
  /// In en, this message translates to:
  /// **'Sending results...'**
  String get sendingResults;

  /// Title of the Result list screen app bar
  ///
  /// In en, this message translates to:
  /// **'Result list screen'**
  String get resultScreenTitle;

  /// Message shown when there are no results to display
  ///
  /// In en, this message translates to:
  /// **'No results available.'**
  String get emptyResultsMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
