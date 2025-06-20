import 'package:flutter/material.dart';

abstract interface class IApplicationTextStyles {
  // Заголовки
  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;
  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  
  // Основной текст
  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;
  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;
  
  // Специальные стили
  TextStyle get buttonText;
  TextStyle get labelText;
  TextStyle get statValue;
  TextStyle get statLabel;
  TextStyle get scoreText;
  TextStyle get playerName;
  TextStyle get matchInfo;
  TextStyle get errorText;
  TextStyle get successText;
  TextStyle get warningText;
}