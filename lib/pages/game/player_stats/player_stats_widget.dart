import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/pages/game/game_page.dart';

class PlayerStatsWidget extends ConsumerWidget {
  const PlayerStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    ref.watch(gameStateProvider.future);
    final gameState = ref.watch(gameStateProvider);
    final currentPlayer = gameState.value?.currentPlayer!;
    final enemyPlayer = gameState.value?.currentRound!.players.firstWhere((player) => player != currentPlayer);

    if(gameState.value == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: theme.gradients.surfaceGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.shadows.primaryShadow,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentPlayer!.user.name,
              style: theme.textStyles.headlineMedium,
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 16.h),
            _buildStatsGrid(theme, currentPlayer, enemyPlayer!),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(IThemeService theme, IPlayer player, IPlayer enemyPlayer) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatItem(theme, 'left_balls'.tr, player.leftBalls.toString()),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatItem(theme, 'current_balls'.tr, player.currentBalls.toString()),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(theme, 'random_balls'.tr, player.randomBalls.toString()),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatItem(theme, 'enemy_balls'.tr, player.enemyBalls.toString()),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(theme, 'left_enemy_balls'.tr, enemyPlayer.leftBalls.toString()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(IThemeService theme, String label, String value) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: theme.colors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: theme.textStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
} 