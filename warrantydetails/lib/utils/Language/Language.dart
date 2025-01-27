import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇮🇳", "हिंदी", "hi"),
      // Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ‎", "ar"),
      Language(3, "🇮🇳", "தமிழ்", "ta"),
      Language(4, "🇮🇳", "മലയാളം", "ml"),
    ];
  }
}

Future<Locale> getSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('languageCode') ?? 'en';
  final countryCode = prefs.getString('countryCode') ?? 'US';
  return Locale(languageCode, countryCode);
}

Future<void> saveLocale(Locale locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', locale.languageCode);
  await prefs.setString('countryCode', locale.countryCode ?? '');
}
