import 'package:billiards/entities/settings/i_settings.dart';
import 'package:billiards/entities/settings/i_settings_repository.dart';
import 'package:billiards/entities/settings/settings.dart';
import 'package:billiards/entities/settings/settings_repository.dart';
import 'package:billiards/services/theme/borders/application_borders.dart';
import 'package:billiards/services/theme/borders/i_application_borders.dart';
import 'package:billiards/services/theme/gradients/application_gradients.dart';
import 'package:billiards/services/theme/shadows/application_shadows.dart';
import 'package:billiards/services/theme/shadows/i_application_shadows.dart';
import 'package:billiards/services/theme/text_styles/application_text_styles.dart';
import 'package:billiards/services/theme/colors/dark_application_theme.dart';
import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/gradients/i_application_gradients.dart';
import 'package:billiards/services/theme/text_styles/i_application_text_styles.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/colors/light_application_theme.dart';
import 'package:billiards/services/theme/theme_type.dart';
import 'package:riverpod/riverpod.dart';

final themeServiceProvider = Provider<IThemeService>((ref) {
  return ref.watch(themeServiceFutureProvider).requireValue;
});

final themeServiceFutureProvider = FutureProvider<IThemeService>((ref) async {
  ref.watch(settingsRepositoryProvider);

  final settingsRepository = await ref.watch(settingsRepositoryProvider.future);
  final settings = await settingsRepository.getSettings();
  return ThemeService(settingsRepository, settings);
});

class ThemeService implements IThemeService {
  final ISettingsRepository _settingsRepository;
  final ISettings _settings;

  ThemeService(this._settingsRepository, this._settings);

  Future<void> setThemeType(ThemeType themeType) async {
    final newSettings = _settings.copyWith(themeMode: themeType);
    await _settingsRepository.updateSettings(newSettings);
  }

  @override
  IApplicationColors get colors => switch (_settings.themeMode) {
        ThemeType.light => LightApplicationColors(),
        ThemeType.dark => DarkApplicationColors(),
      };

  @override
  IApplicationTextStyles get textStyles => ApplicationTextStyles(colors);

  @override
  IApplicationGradients get gradients => ApplicationGradients(colors);

  @override
  IApplicationShadows get shadows => ApplicationShadows(colors);

  @override
  IApplicationBorders get borders => ApplicationBorders(colors);
}
