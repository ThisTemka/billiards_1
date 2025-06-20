import 'package:billiards/services/theme/borders/i_application_borders.dart';
import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/gradients/i_application_gradients.dart';
import 'package:billiards/services/theme/shadows/i_application_shadows.dart';
import 'package:billiards/services/theme/text_styles/i_application_text_styles.dart';

abstract interface class IThemeService {
  IApplicationColors get colors;
  IApplicationTextStyles get textStyles;
  IApplicationGradients get gradients;
  IApplicationShadows get shadows;
  IApplicationBorders get borders;
}

