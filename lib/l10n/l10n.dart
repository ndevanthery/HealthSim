import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('de'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return 'EN';
      case 'fr':
        return 'FR';
      case 'de':
        return 'DE';
      default:
        return 'Unknown';
    }
  }
}
