import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:flutter/material.dart';

class LightApplicationColors implements IApplicationColors {
  // Основные цвета
  @override
  Color get primaryBackground => const Color(0xFFF5F5F5);
  @override
  Color get secondaryBackground => const Color(0xFFE8E8E8);
  @override
  Color get surfaceColor => const Color(0xFFFFFFFF);
  
  // Акцентные цвета
  @override
  Color get primaryAccent => const Color(0xFF2C3E50); // Тёмно-синий, как сукно бильярдного стола
  @override
  Color get secondaryAccent => const Color(0xFFE74C3C); // Красный, как бильярдный шар
  @override
  Color get tertiaryAccent => const Color(0xFF27AE60); // Зелёный, как сукно стола
  
  // Текстовые цвета
  @override
  Color get primaryText => const Color(0xFF2C3E50);
  @override
  Color get secondaryText => const Color(0xFF7F8C8D);
  @override
  Color get accentText => const Color(0xFFFFFFFF);
  
  // Цвета для статистики
  @override
  Color get positiveStat => const Color(0xFF27AE60);
  @override
  Color get negativeStat => const Color(0xFFE74C3C);
  @override
  Color get neutralStat => const Color(0xFFF1C40F);
  
  // Цвета для элементов интерфейса
  @override
  Color get dividerColor => const Color(0xFFE0E0E0);
  @override
  Color get shadowColor => const Color(0x1A000000);
  @override
  Color get overlayColor => const Color(0x80000000);
  
  // Цвета для кнопок
  @override
  Color get primaryButton => const Color(0xFF2C3E50);
  @override
  Color get secondaryButton => const Color(0xFFE74C3C);
  @override
  Color get disabledButton => const Color(0xFFBDC3C7);
  
  // Цвета для индикаторов
  @override
  Color get successColor => const Color(0xFF27AE60);
  @override
  Color get errorColor => const Color(0xFFE74C3C);
  @override
  Color get warningColor => const Color(0xFFF1C40F);
  @override
  Color get infoColor => const Color(0xFF3498DB);
}