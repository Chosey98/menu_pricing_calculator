import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/app_settings.dart';

const settingsBoxName = 'settings';
const settingsKey = 'app_settings';

class SettingsRepository {
  Box<AppSettings> get _box => Hive.box<AppSettings>(settingsBoxName);

  AppSettings load() {
    try {
      final settings = _box.get(settingsKey);
      if (settings == null) return AppSettings.defaults;
      if (settings.localeCode.isEmpty) {
        return settings.copyWith(localeCode: 'en');
      }
      return settings;
    } catch (_) {
      return AppSettings.defaults;
    }
  }

  Future<void> save(AppSettings settings) async {
    await _box.put(settingsKey, settings);
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._repository) : super(_repository.load());

  final SettingsRepository _repository;

  Future<void> update(AppSettings settings) async {
    state = settings;
    await _repository.save(settings);
  }

  Future<void> updateField(AppSettings Function(AppSettings) updater) async {
    await update(updater(state));
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

final appSettingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier(ref.watch(settingsRepositoryProvider));
});
