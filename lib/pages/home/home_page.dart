import 'package:billiards/entities/game_state/game_state_repository.dart';
import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:get/get.dart';
import 'package:billiards/entities/match/match_repository.dart';
import 'package:billiards/services/translation/translation_service.dart';

final hasUnfinishedMatchProvider = FutureProvider.autoDispose<bool>((ref) async {
  ref.watch(gameStateRepositoryProvider);
  final gameStateRepository = await ref.watch(gameStateRepositoryProvider.future);
  final gameState = await gameStateRepository.getGameState();
  return gameState.currentMatch != null; 
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final hasUnfinishedMatch = ref.watch(hasUnfinishedMatchProvider);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  'app_title'.tr,
                  style: theme.textStyles.headlineLarge.copyWith(
                    color: theme.colors.primaryText,
                  ),
                ).animate().fadeIn().slideX(),
                SizedBox(height: 8.h),
                Text(
                  'app_subtitle'.tr,
                  style: theme.textStyles.bodyLarge.copyWith(
                    color: theme.colors.secondaryText,
                  ),
                ).animate().fadeIn().slideX(delay: 200.ms),
                SizedBox(height: 40.h),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    children: [
                      _buildMenuCard(
                        context,
                        theme,
                        'new_game'.tr,
                        Icons.play_circle_outline,
                        () async {
                          final gameStateRepository = await ref.read(gameStateRepositoryProvider.future);
                          final gameState = await gameStateRepository.getGameState();
                          final newGameState = gameState.copyWith(
                            nullMatch: true,
                            nullRound: true,
                            nullPlayer: true,
                            gameStatus: GameStatus.playerSelection,
                          );
                          await gameStateRepository.setGameState(newGameState);
                          Get.toNamed('/game');
                        },
                      ),
                      if (hasUnfinishedMatch.when(
                        data: (hasMatch) => hasMatch,
                        loading: () => false,
                        error: (_, __) => false,
                      ))
                        _buildMenuCard(
                          context,
                          theme,
                          'continue'.tr,
                          Icons.history,
                          () => Get.toNamed('/game'),
                        ),
                      _buildMenuCard(
                        context,
                        theme,
                        'history'.tr,
                        Icons.timeline,
                        () => Get.toNamed('/history'),
                      ),
                      _buildMenuCard(
                        context,
                        theme,
                        'players'.tr,
                        Icons.people,
                        () => Get.toNamed('/users'),
                      ),
                      _buildMenuCard(
                        context,
                        theme,
                        'settings'.tr,
                        Icons.settings,
                        () => Get.toNamed('/settings'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    IThemeService theme,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            gradient: theme.gradients.cardGradient,
            borderRadius: BorderRadius.circular(16.r),
            border: theme.borders.primaryBorder,
            boxShadow: theme.shadows.cardShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32.w,
                color: theme.colors.primaryAccent,
              ).animate().scale(delay: 300.ms),
              SizedBox(height: 12.h),
              Text(
                title,
                style: theme.textStyles.titleMedium.copyWith(
                  color: theme.colors.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().scale(delay: 400.ms);
  }
}