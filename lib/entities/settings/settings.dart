import 'dart:ui';

import 'package:billiards/entities/settings/i_settings.dart';
import 'package:billiards/services/theme/theme_type.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Settings implements ISettings {
  @override
  late int id;
  @override
  @Transient()
  ThemeType get themeMode => ThemeType.values[themeModeId];
  final int themeModeId;
  @override
  @Transient()
  Locale get language => Locale(languageCode);
  final String languageCode;

  Settings({
    required this.id,
    required this.themeModeId,
    required this.languageCode,
  });

  @override
  ISettings copyWith({
    ThemeType? themeMode,
    Locale? language,
  }) {
    return Settings(
      id: id,
      themeModeId: themeMode?.index ?? themeModeId,
      languageCode: language?.languageCode ?? languageCode,
    );
  }
}
