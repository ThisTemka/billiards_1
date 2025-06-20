import 'package:billiards/entities/settings/i_settings.dart';

abstract interface class ISettingsRepository{
  Future<ISettings> getSettings();
  Future<int> updateSettings(ISettings settings);
}
