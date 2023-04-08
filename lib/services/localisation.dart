import 'dart:convert';

import 'package:app/app.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalisation {
  final Locale locale;
  AppLocalisation(this.locale);
  Map<String, String>? _localizedValues;

  static List<LocalizationsDelegate<dynamic>> appDeleteGate = [
    AppLocalisation.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static AppLocalisation? of(BuildContext context) {
    return Localizations.of<AppLocalisation>(context, AppLocalisation);
  }

  static const List<Locale> supportedLocale = [
    Locale("en", "US"),
    Locale("ar", "SA"),
  ];

  Future<void> load() async {
    String jsonStringValues =
        await rootBundle.loadString('assets/json/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues![key];
  }

  static Future<Locale> setLocale(String languageCode) async {
    LocalStore.saveData(LSKeySelectedLanguage, languageCode);
    return _locale(languageCode);
  }

  static Future<Locale> getLocale() async {
    String languageCode =
        await LocalStore.getData(LSKeySelectedLanguage) ?? "en";
    return _locale(languageCode);
  }

  static Locale _locale(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return const Locale(ENGLISH, 'US');

      case ARABIC:
        return const Locale(ARABIC, "SA");

      default:
        return const Locale(ENGLISH, 'US');
    }
  }

  static changeLanguage(String language, BuildContext context) async {
    Locale _locale = await setLocale(language);
    MyApp.setLocale(context, _locale);
  }

  static String getTranslated(BuildContext context, String key) {
    return AppLocalisation.of(context)!.translate(key)!;
  }

  static const LocalizationsDelegate<AppLocalisation> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalisation> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalisation> load(Locale locale) async {
    AppLocalisation localization = AppLocalisation(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalisation> old) =>
      false;
}
