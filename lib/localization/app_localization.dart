import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aqar_bazar/Provider/modelsProvider.dart';

class Applocalizations {
  final Locale locale;

  Applocalizations(this.locale);

  static Applocalizations of(BuildContext context) {
    return Localizations.of<Applocalizations>(context, Applocalizations);
  }

  static LocalizationsDelegate<Applocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;
  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    //print(_localizedStrings[key]);
    return _localizedStrings[key];
  }

  /* void setAppLocale(BuildContext context){
    Provider.of<ModelsProvider>(context, listen: false).setLocale(locale);
  } */
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<Applocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<Applocalizations> load(Locale locale) async {
    Applocalizations localization = new Applocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Applocalizations> old) {
    return false;
  }
}
