import 'package:billiards/services/theme/colors/i_application_colors.dart';
import 'package:flutter/material.dart';

class DarkApplicationColors implements IApplicationColors {
  // Основные цвета
  @override
  Color get primaryBackground => const Color(0xFF1A1A1A);
  @override
  Color get secondaryBackground => const Color(0xFF2C2C2C);
  @override
  Color get surfaceColor => const Color(0xFF333333);
  
  // Акцентные цвета
  @override
  Color get primaryAccent => const Color(0xFF3498DB); // Яркий синий для контраста
  @override
  Color get secondaryAccent => const Color(0xFFE74C3C); // Красный, как бильярдный шар
  @override
  Color get tertiaryAccent => const Color(0xFF2ECC71); // Яркий зелёный для акцентов
  
  // Текстовые цвета
  @override
  Color get primaryText => const Color(0xFFECF0F1);
  @override
  Color get secondaryText => const Color(0xFFBDC3C7);
  @override
  Color get accentText => const Color(0xFFFFFFFF);
  
  // Цвета для статистики
  @override
  Color get positiveStat => const Color(0xFF2ECC71);
  @override
  Color get negativeStat => const Color(0xFFE74C3C);
  @override
  Color get neutralStat => const Color(0xFFF1C40F);
  
  // Цвета для элементов интерфейса
  @override
  Color get dividerColor => const Color(0xFF404040);
  @override
  Color get shadowColor => const Color(0x40000000);
  @override
  Color get overlayColor => const Color(0xCC000000);
  
  // Цвета для кнопок
  @override
  Color get primaryButton => const Color(0xFF3498DB);
  @override
  Color get secondaryButton => const Color(0xFFE74C3C);
  @override
  Color get disabledButton => const Color(0xFF7F8C8D);
  
  // Цвета для индикаторов
  @override
  Color get successColor => const Color(0xFF2ECC71);
  @override
  Color get errorColor => const Color(0xFFE74C3C);
  @override
  Color get warningColor => const Color(0xFFF1C40F);
  @override
  Color get infoColor => const Color(0xFF3498DB);
}