import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/states/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _prefix = "quiet:settings";
const String _keyThemeMode = "$_prefix:themeMode";

final settingProvider = StateNotifierProvider<SettingNotifier, Setting>((ref) => SettingNotifier(ref.read(sharedPreferenceProvider)));

class Setting {
  const Setting({
    required this.themeMode,
  });

  final ThemeMode themeMode;

  factory Setting.fromPreference(SharedPreferences preference) {
    final mode = preference.getInt(_keyThemeMode) ?? 0;
    assert(mode >= 0 && mode < ThemeMode.values.length, 'invalid theme mode');
    return Setting(themeMode: ThemeMode.values[mode.clamp(0, ThemeMode.values.length - 1)]);
  }

  Setting copyWith({ThemeMode? themeMode}) => Setting(themeMode: themeMode ?? this.themeMode);
}

class SettingNotifier extends StateNotifier<Setting> {
  SettingNotifier(this._preferences): super(Setting.fromPreference(_preferences));

  final SharedPreferences _preferences;

  void setThemeMode(ThemeMode themeMode) {
    _preferences.setInt(_keyThemeMode, themeMode.index);
    state = state.copyWith(themeMode: themeMode);
  }
}