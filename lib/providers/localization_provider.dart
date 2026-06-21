import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import 'settings_provider.dart';

final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  final settings = ref.watch(appSettingsProvider);
  return AppLocalizations.of(settings.localeCode);
});
