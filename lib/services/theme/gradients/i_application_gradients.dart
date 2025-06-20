import 'package:flutter/material.dart';

abstract interface class IApplicationGradients {
  // Основные градиенты
  LinearGradient get primaryGradient;
  LinearGradient get secondaryGradient;
  LinearGradient get surfaceGradient;
  
  // Акцентные градиенты
  LinearGradient get accentGradient;
  LinearGradient get successGradient;
  LinearGradient get warningGradient;
  LinearGradient get errorGradient;
  
  // Специальные градиенты
  LinearGradient get buttonGradient;
  LinearGradient get cardGradient;
  LinearGradient get headerGradient;
  LinearGradient get scoreGradient;
  LinearGradient get playerGradient;
  LinearGradient get matchGradient;
  
  // Декоративные градиенты
  LinearGradient get borderGradient;
  LinearGradient get shadowGradient;
  LinearGradient get overlayGradient;
}