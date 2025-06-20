import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/borders/i_application_borders.dart';
import 'package:flutter/material.dart';

class ApplicationBorders implements IApplicationBorders {
  final IApplicationColors colors;

  ApplicationBorders(this.colors);

  // Основные границы
  @override
  Border get primaryBorder => Border.all(
    color: colors.primaryAccent.withAlpha(25),
    width: 1,
  );

  @override
  Border get secondaryBorder => Border.all(
    color: colors.secondaryAccent.withAlpha(25),
    width: 1,
  );

  @override
  Border get surfaceBorder => Border.all(
    color: colors.surfaceColor.withAlpha(25),
    width: 1,
  );

  // Акцентные границы
  @override
  Border get accentBorder => Border.all(
    color: colors.primaryAccent.withAlpha(51),
    width: 2,
  );

  @override
  Border get successBorder => Border.all(
    color: colors.successColor.withAlpha(51),
    width: 2,
  );

  @override
  Border get warningBorder => Border.all(
    color: colors.warningColor.withAlpha(51),
    width: 2,
  );

  @override
  Border get errorBorder => Border.all(
    color: colors.errorColor.withAlpha(51),
    width: 2,
  );

  // Специальные границы
  @override
  Border get buttonBorder => Border.all(
    color: colors.primaryButton.withAlpha(51),
    width: 1.5,
  );

  @override
  Border get cardBorder => Border.all(
    color: colors.primaryAccent.withAlpha(25),
    width: 1,
  );

  @override
  Border get headerBorder => Border(
    bottom: BorderSide(
      color: colors.primaryAccent.withAlpha(25),
      width: 1,
    ),
  );

  @override
  Border get scoreBorder => Border.all(
    color: colors.primaryAccent.withAlpha(76),
    width: 2,
  );

  @override
  Border get playerBorder => Border.all(
    color: colors.primaryAccent.withAlpha(38),
    width: 1.5,
  );

  @override
  Border get matchBorder => Border.all(
    color: colors.tertiaryAccent.withAlpha(51),
    width: 2,
  );

  // Декоративные границы
  @override
  Border get dividerBorder => Border(
    bottom: BorderSide(
      color: colors.dividerColor.withAlpha(25),
      width: 1,
    ),
  );

  @override
  Border get hoverBorder => Border.all(
    color: colors.primaryAccent.withAlpha(38),
    width: 1.5,
  );

  @override
  Border get pressBorder => Border.all(
    color: colors.primaryAccent.withAlpha(51),
    width: 2,
  );

  @override
  Border get elevationBorder => Border.all(
    color: colors.primaryAccent.withAlpha(25),
    width: 1,
  );

  // Радиусы скругления
  @override
  BorderRadius get primaryRadius => const BorderRadius.all(
    Radius.circular(8),
  );

  @override
  BorderRadius get secondaryRadius => const BorderRadius.all(
    Radius.circular(12),
  );

  @override
  BorderRadius get accentRadius => const BorderRadius.all(
    Radius.circular(16),
  );

  @override
  BorderRadius get buttonRadius => const BorderRadius.all(
    Radius.circular(8),
  );

  @override
  BorderRadius get cardRadius => const BorderRadius.all(
    Radius.circular(12),
  );

  @override
  BorderRadius get scoreRadius => const BorderRadius.all(
    Radius.circular(20),
  );

  @override
  BorderRadius get playerRadius => const BorderRadius.all(
    Radius.circular(16),
  );

  @override
  BorderRadius get matchRadius => const BorderRadius.all(
    Radius.circular(16),
  );
}
