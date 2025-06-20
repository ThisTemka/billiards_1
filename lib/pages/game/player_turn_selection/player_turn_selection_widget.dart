import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/pages/game/game_page.dart';
import 'package:get/get.dart';

class PlayerTurnSelectionWidget extends ConsumerWidget {
  final Function(IPlayer) onPlayerTurnSelected;

  const PlayerTurnSelectionWidget({
    super.key,
    required this.onPlayerTurnSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final gameState = ref.watch(gameStateProvider);
    final currentRound = gameState.value?.currentRound!;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'select_player_turn'.tr,
            style: theme.textStyles.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ...currentRound!.players.map((player) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: ElevatedButton(
              onPressed: () => onPlayerTurnSelected(player),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primaryButton,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                player.user.name,
                style: theme.textStyles.bodyLarge.copyWith(
                  color: theme.colors.accentText,
                ),
              ),
            ),
          )),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
} 