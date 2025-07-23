import 'package:custom_firebase_login/core/utils/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension TranslateX on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}