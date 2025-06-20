import 'package:flutter/material.dart';

abstract interface class IApplicationBorders {
  // Основные границы
  Border get primaryBorder;
  Border get secondaryBorder;
  Border get surfaceBorder;
  
  // Акцентные границы
  Border get accentBorder;
  Border get successBorder;
  Border get warningBorder;
  Border get errorBorder;
  
  // Специальные границы
  Border get buttonBorder;
  Border get cardBorder;
  Border get headerBorder;
  Border get scoreBorder;
  Border get playerBorder;
  Border get matchBorder;
  
  // Декоративные границы
  Border get dividerBorder;
  Border get hoverBorder;
  Border get pressBorder;
  Border get elevationBorder;
  
  // Радиусы скругления
  BorderRadius get primaryRadius;
  BorderRadius get secondaryRadius;
  BorderRadius get accentRadius;
  BorderRadius get buttonRadius;
  BorderRadius get cardRadius;
  BorderRadius get scoreRadius;
  BorderRadius get playerRadius;
  BorderRadius get matchRadius;
}