import 'package:billiards/entities/settings/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/services/theme/theme_type.dart';
import 'package:billiards/services/theme/colors/light_application_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final currentTheme =
        ref.watch(themeServiceProvider).colors is LightApplicationColors
            ? ThemeType.light
            : ThemeType.dark;
    final currentLocale = Get.locale?.languageCode ?? 'en';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildHeader(theme),
                SizedBox(height: 24.h),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: theme.gradients.cardGradient,
                      borderRadius: theme.borders.cardRadius,
                      boxShadow: theme.shadows.cardShadow,
                      border: theme.borders.cardBorder,
                    ),
                    child: ListView(
                      padding: EdgeInsets.all(16.w),
                      children: [
                        _buildSection(
                          theme,
                          'appearance'.tr,
                          [
                            _buildThemeSelector(theme, currentTheme, ref),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        _buildSection(
                          theme,
                          'preferences'.tr,
                          [
                            _buildLanguageSelector(theme, currentLocale, ref),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(IThemeService theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'settings'.tr,
          style: theme.textStyles.titleLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideX(),
      ],
    );
  }

  Widget _buildSection(
      IThemeService theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textStyles.titleMedium,
        ),
        SizedBox(height: 16.h),
        ...children,
      ],
    );
  }

  Widget _buildThemeSelector(
      IThemeService theme, ThemeType currentTheme, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.secondaryBackground.withOpacity(0.1),
        borderRadius: theme.borders.primaryRadius,
      ),
      child: Column(
        children: [
          _buildThemeOption(
            theme,
            'light_theme'.tr,
            currentTheme == ThemeType.light,
            () {
              (ref.read(themeServiceProvider) as ThemeService)
                  .setThemeType(ThemeType.light);
            },
          ),
          Divider(
            color: theme.colors.secondaryBackground.withOpacity(0.2),
            height: 1,
          ),
          _buildThemeOption(
            theme,
            'dark_theme'.tr,
            currentTheme == ThemeType.dark,
            () {
              (ref.read(themeServiceProvider) as ThemeService)
                  .setThemeType(ThemeType.dark);
            },
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildThemeOption(
    IThemeService theme,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: theme.borders.primaryRadius,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textStyles.bodyMedium,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colors.primaryAccent,
                size: 24.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
      IThemeService theme, String currentLocale, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.secondaryBackground.withOpacity(0.1),
        borderRadius: theme.borders.primaryRadius,
      ),
      child: Column(
        children: [
          _buildLanguageOption(
            theme,
            'english'.tr,
            currentLocale == 'en',
            () async {
              final settingsRepository =
                  await ref.read(settingsRepositoryProvider.future);
              final settings = await settingsRepository.getSettings();
              final newSettings =
                  settings.copyWith(language: const Locale('en'));
              await settingsRepository.updateSettings(newSettings);
            },
          ),
          Divider(
            color: theme.colors.secondaryBackground.withOpacity(0.2),
            height: 1,
          ),
          _buildLanguageOption(
            theme,
            'russian'.tr,
            currentLocale == 'ru',
            () async {
              final settingsRepository =
                  await ref.read(settingsRepositoryProvider.future);
              final settings = await settingsRepository.getSettings();
              final newSettings =
                  settings.copyWith(language: const Locale('ru'));
              await settingsRepository.updateSettings(newSettings);
            },
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildLanguageOption(
    IThemeService theme,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: theme.borders.primaryRadius,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textStyles.bodyMedium,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colors.primaryAccent,
                size: 24.w,
              ),
          ],
        ),
      ),
    );
  }
}
