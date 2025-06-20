import 'dart:ui';

import 'package:billiards/services/store/i_entity.dart';
import 'package:billiards/services/theme/theme_type.dart';

abstract interface class ISettings implements IEntity {
  ThemeType get themeMode;
  Locale get language;

  ISettings copyWith({
    ThemeType? themeMode,
    Locale? language,
  });
}
