import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/shadows/i_application_shadows.dart';
import 'package:flutter/material.dart';

class ApplicationShadows implements IApplicationShadows {
  final IApplicationColors colors;

  ApplicationShadows(this.colors);

  // Основные тени
  @override
  List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(15),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get secondaryShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(30),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(20),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get surfaceShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(20),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // Акцентные тени
  @override
  List<BoxShadow> get accentShadow => [
    BoxShadow(
      color: colors.primaryAccent.withAlpha(51),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.primaryAccent.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get successShadow => [
    BoxShadow(
      color: colors.successColor.withAlpha(51),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.successColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get warningShadow => [
    BoxShadow(
      color: colors.warningColor.withAlpha(51),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.warningColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get errorShadow => [
    BoxShadow(
      color: colors.errorColor.withAlpha(51),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.errorColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // Специальные тени
  @override
  List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: colors.primaryButton.withAlpha(51),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.primaryButton.withAlpha(25),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(25),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(15),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get headerShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(30),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get scoreShadow => [
    BoxShadow(
      color: colors.primaryAccent.withAlpha(76),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.primaryAccent.withAlpha(51),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get playerShadow => [
    BoxShadow(
      color: colors.primaryAccent.withAlpha(38),
      offset: const Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.primaryAccent.withAlpha(25),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get matchShadow => [
    BoxShadow(
      color: colors.tertiaryAccent.withAlpha(51),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.tertiaryAccent.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // Декоративные тени
  @override
  List<BoxShadow> get borderShadow => [
    BoxShadow(
      color: colors.primaryAccent.withAlpha(25),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get hoverShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(38),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get pressShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(13),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  @override
  List<BoxShadow> get elevationShadow => [
    BoxShadow(
      color: colors.shadowColor.withAlpha(51),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: colors.shadowColor.withAlpha(25),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
}