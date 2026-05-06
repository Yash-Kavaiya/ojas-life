import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(_loadSaved());

  static Locale _loadSaved() {
    final code = StorageService.prefs.get('locale', defaultValue: 'en') as String;
    return Locale(code);
  }

  void setLocale(Locale locale) {
    StorageService.prefs.put('locale', locale.languageCode);
    state = locale;
  }

  void setHindi() => setLocale(const Locale('hi'));
  void setEnglish() => setLocale(const Locale('en'));
}
