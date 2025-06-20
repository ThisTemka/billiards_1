import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/gradients/i_application_gradients.dart';
import 'package:flutter/material.dart';

class ApplicationGradients implements IApplicationGradients {
  final IApplicationColors colors;

  ApplicationGradients(this.colors);

  // Основные градиенты
  @override
  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryBackground,
      colors.primaryBackground.withAlpha(242),
      colors.secondaryBackground,
    ],
  );

  @override
  LinearGradient get secondaryGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colors.secondaryBackground,
      colors.secondaryBackground.withAlpha(242),
      colors.surfaceColor,
    ],
  );

  @override
  LinearGradient get surfaceGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.surfaceColor,
      colors.surfaceColor.withAlpha(242),
      colors.surfaceColor.withAlpha(229),
    ],
  );

  // Акцентные градиенты
  @override
  LinearGradient get accentGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryAccent,
      colors.primaryAccent.withAlpha(229),
      colors.secondaryAccent,
    ],
  );

  @override
  LinearGradient get successGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.successColor,
      colors.successColor.withAlpha(229),
      colors.tertiaryAccent,
    ],
  );

  @override
  LinearGradient get warningGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.warningColor,
      colors.warningColor.withAlpha(229),
      colors.warningColor.withAlpha(204),
    ],
  );

  @override
  LinearGradient get errorGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.errorColor,
      colors.errorColor.withAlpha(229),
      colors.secondaryAccent,
    ],
  );

  // Специальные градиенты
  @override
  LinearGradient get buttonGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryButton,
      colors.primaryButton.withAlpha(229),
      colors.secondaryButton,
    ],
  );

  @override
  LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.surfaceColor,
      colors.surfaceColor.withAlpha(242),
      colors.secondaryBackground,
    ],
  );

  @override
  LinearGradient get headerGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colors.primaryAccent,
      colors.primaryAccent.withAlpha(242),
      colors.primaryAccent.withAlpha(229),
    ],
  );

  @override
  LinearGradient get scoreGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryAccent,
      colors.primaryAccent.withAlpha(242),
      colors.secondaryAccent,
    ],
  );

  @override
  LinearGradient get playerGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryAccent.withAlpha(229),
      colors.primaryAccent.withAlpha(204),
      colors.primaryAccent.withAlpha(178),
    ],
  );

  @override
  LinearGradient get matchGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.tertiaryAccent,
      colors.tertiaryAccent.withAlpha(229),
      colors.primaryAccent,
    ],
  );

  // Декоративные градиенты
  @override
  LinearGradient get borderGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      colors.primaryAccent.withAlpha(128),
      colors.primaryAccent.withAlpha(76),
      colors.primaryAccent.withAlpha(25),
    ],
  );

  @override
  LinearGradient get shadowGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colors.shadowColor.withAlpha(25),
      colors.shadowColor.withAlpha(13),
      colors.shadowColor.withAlpha(0),
    ],
  );

  @override
  LinearGradient get overlayGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colors.overlayColor.withAlpha(204),
      colors.overlayColor.withAlpha(153),
      colors.overlayColor.withAlpha(102),
    ],
  );
}