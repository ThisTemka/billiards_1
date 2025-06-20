import 'package:flutter/material.dart';

abstract interface class IApplicationShadows {
  // Основные тени
  List<BoxShadow> get primaryShadow;
  List<BoxShadow> get secondaryShadow;
  List<BoxShadow> get surfaceShadow;
  
  // Акцентные тени
  List<BoxShadow> get accentShadow;
  List<BoxShadow> get successShadow;
  List<BoxShadow> get warningShadow;
  List<BoxShadow> get errorShadow;
  
  // Специальные тени
  List<BoxShadow> get buttonShadow;
  List<BoxShadow> get cardShadow;
  List<BoxShadow> get headerShadow;
  List<BoxShadow> get scoreShadow;
  List<BoxShadow> get playerShadow;
  List<BoxShadow> get matchShadow;
  
  // Декоративные тени
  List<BoxShadow> get borderShadow;
  List<BoxShadow> get hoverShadow;
  List<BoxShadow> get pressShadow;
  List<BoxShadow> get elevationShadow;
}