import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:billiards/services/theme/text_styles/i_application_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTextStyles implements IApplicationTextStyles {
  final IApplicationColors colors;

  ApplicationTextStyles(this.colors);

  // Заголовки
  @override
  TextStyle get displayLarge => GoogleFonts.montserrat(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    color: colors.primaryText,
  );

  @override
  TextStyle get displayMedium => GoogleFonts.montserrat(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  @override
  TextStyle get displaySmall => GoogleFonts.montserrat(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  @override
  TextStyle get headlineLarge => GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  @override
  TextStyle get headlineMedium => GoogleFonts.montserrat(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  @override
  TextStyle get headlineSmall => GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  // Основной текст
  @override
  TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: colors.primaryText,
  );

  @override
  TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: colors.primaryText,
  );

  @override
  TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: colors.primaryText,
  );

  @override
  TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: colors.primaryText,
  );

  @override
  TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: colors.primaryText,
  );

  @override
  TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: colors.secondaryText,
  );

  // Специальные стили
  @override
  TextStyle get buttonText => GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
    color: colors.accentText,
  );

  @override
  TextStyle get labelText => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: colors.secondaryText,
  );

  @override
  TextStyle get statValue => GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: colors.primaryAccent,
  );

  @override
  TextStyle get statLabel => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: colors.secondaryText,
  );

  @override
  TextStyle get scoreText => GoogleFonts.montserrat(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: colors.primaryAccent,
  );

  @override
  TextStyle get playerName => GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: colors.primaryText,
  );

  @override
  TextStyle get matchInfo => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: colors.secondaryText,
  );

  @override
  TextStyle get errorText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: colors.errorColor,
  );

  @override
  TextStyle get successText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: colors.successColor,
  );

  @override
  TextStyle get warningText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: colors.warningColor,
  );
}
