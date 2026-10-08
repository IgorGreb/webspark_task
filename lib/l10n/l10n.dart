import 'package:flutter/widgets.dart';

import 'package:webspark_task/l10n/gen/app_localizations.dart';

export 'package:webspark_task/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  AppLocalizations? get maybeL10n =>
      Localizations.of<AppLocalizations>(this, AppLocalizations);
}

/// Default locale used on first launch.
const Locale defaultLocale = Locale('en');

/// Locales supported by the app (re-exported from generated code).
const List<Locale> supportedLocales = AppLocalizations.supportedLocales;

/// Delegates for [MaterialApp.router] (re-exported from generated code).
const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
    AppLocalizations.localizationsDelegates;
