import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/pages/game/game_page.dart';
import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/entities/game_state/i_game_state_repository.dart';
import 'package:billiards/entities/game_state/game_state_repository.dart';

class GameStatisticsPage extends ConsumerWidget {
  const GameStatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final gameState = ref.watch(gameStateProvider);

    if (gameState.value == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16.h),
              Text(
                'no_match_data'.tr,
                style: theme.textStyles.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    final currentMatch = gameState.value!.currentMatch!;
    final player1 = currentMatch.users[0];
    final player2 = currentMatch.users[1];

    // Подсчет общей статистики за все раунды
    int totalBalls1 = 0;
    int totalBalls2 = 0;
    double totalAccuracy1 = 0;
    double totalAccuracy2 = 0;
    int totalMaxMoveInLine1 = 0;
    int totalMaxMoveInLine2 = 0;
    double totalAverageMoveInLine1 = 0;
    double totalAverageMoveInLine2 = 0;
    Duration totalAverageMoveDuration1 = Duration.zero;
    Duration totalAverageMoveDuration2 = Duration.zero;
    int totalErrorMove1 = 0;
    int totalErrorMove2 = 0;
    int totalRoundsWon1 = 0;
    int totalRoundsWon2 = 0;

    for (final round in currentMatch.rounds) {
      // Находим статистику игроков по индексу в массиве players
      final player1Stats = round.players[0];
      final player2Stats = round.players[1];

      totalBalls1 += player1Stats.currentBalls + player1Stats.randomBalls;
      totalBalls2 += player2Stats.currentBalls + player2Stats.randomBalls;

      totalErrorMove1 += player1Stats.errorMoves + player1Stats.loseMoves;
      totalErrorMove2 += player2Stats.errorMoves + player2Stats.loseMoves;

      if (player1Stats.win) totalRoundsWon1++;
      if (player2Stats.win) totalRoundsWon2++;
    }
    totalAccuracy1 = currentMatch.rounds
            .fold(0, (a, b) => a + b.players[0].moveScores) /
        (currentMatch.rounds.fold(0, (a, b) => a + b.players[0].moves) == 0
            ? 1
            : currentMatch.rounds.fold(0, (a, b) => a + b.players[0].moves));
    totalAccuracy2 = currentMatch.rounds
            .fold(0, (a, b) => a + b.players[1].moveScores) /
        (currentMatch.rounds.fold(0, (a, b) => a + b.players[1].moves) == 0
            ? 1
            : currentMatch.rounds.fold(0, (a, b) => a + b.players[1].moves));

    totalMaxMoveInLine1 = currentMatch.rounds.fold(
        0,
        (a, b) =>
            a > b.players[0].maxMoveInLine ? a : b.players[0].maxMoveInLine);
    totalMaxMoveInLine2 = currentMatch.rounds.fold(
        0,
        (a, b) =>
            a > b.players[1].maxMoveInLine ? a : b.players[1].maxMoveInLine);

    totalAverageMoveInLine1 = currentMatch.rounds.fold(
        0,
        (a, b) =>
            a +
            b.players[0].movesInLines.fold(0, (a, b) => a + b) /
                (currentMatch.rounds.fold(0,
                            (a, b) => a + b.players[0].movesInLines.length) ==
                        0
                    ? 1
                    : currentMatch.rounds.fold(
                        0, (a, b) => a + b.players[0].movesInLines.length)));
    totalAverageMoveInLine2 = currentMatch.rounds.fold(
        0,
        (a, b) =>
            a +
            b.players[1].movesInLines.fold(0, (a, b) => a + b) /
                (currentMatch.rounds.fold(0,
                            (a, b) => a + b.players[1].movesInLines.length) ==
                        0
                    ? 1
                    : currentMatch.rounds.fold(
                        0, (a, b) => a + b.players[1].movesInLines.length)));

    totalAverageMoveDuration1 = currentMatch.rounds.fold(
        Duration.zero,
        (a, b) =>
            a +
            b.players[0].moveDurations.fold(Duration.zero, (a, b) => a + b) ~/
                ((currentMatch.rounds.fold(0,
                            (a, b) => a + b.players[0].moveDurations.length) ==
                        0)
                    ? 1
                    : currentMatch.rounds.fold(
                        0, (a, b) => a + b.players[0].moveDurations.length)));
    totalAverageMoveDuration2 = currentMatch.rounds.fold(
        Duration.zero,
        (a, b) =>
            a +
            b.players[1].moveDurations.fold(Duration.zero, (a, b) => a + b) ~/
                ((currentMatch.rounds.fold(0,
                            (a, b) => a + b.players[1].moveDurations.length) ==
                        0)
                    ? 1
                    : currentMatch.rounds.fold(
                        0, (a, b) => a + b.players[1].moveDurations.length)));

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
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildPlayerHeader(
                                  theme,
                                  player1.name,
                                  totalRoundsWon1,
                                  totalRoundsWon1 > totalRoundsWon2,
                                ),
                              ),
                              Expanded(
                                child: _buildPlayerHeader(
                                  theme,
                                  player2.name,
                                  totalRoundsWon2,
                                  totalRoundsWon2 > totalRoundsWon1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            children: [
                              _buildStatItem(
                                  theme, 'balls'.tr, totalBalls1, totalBalls2),
                              _buildPercentStatItem(theme, 'accuracy'.tr,
                                  totalAccuracy1, totalAccuracy2),
                              _buildStatItem(theme, 'max_move_in_line'.tr,
                                  totalMaxMoveInLine1, totalMaxMoveInLine2),
                              _buildDoubleStatItem(
                                  theme,
                                  'average_move_in_line'.tr,
                                  totalAverageMoveInLine1,
                                  totalAverageMoveInLine2),
                              _buildDurationStatItem(
                                  theme,
                                  'average_move_duration'.tr,
                                  totalAverageMoveDuration1,
                                  totalAverageMoveDuration2),
                              _buildStatItem(theme, 'error_move'.tr,
                                  totalErrorMove1, totalErrorMove2,
                                  isReverse: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        theme,
                        'new_match'.tr,
                        Icons.add_circle_outline,
                        () async {
                          final gameStateRepository = await ref
                              .read(gameStateRepositoryProvider.future);
                          if (gameStateRepository != null) {
                            final newGameState = gameState.value!.copyWith(
                              nullMatch: true,
                              nullRound: true,
                              nullPlayer: true,
                              gameStatus: GameStatus.playerSelection,
                            );
                            await gameStateRepository
                                .setGameState(newGameState);
                          }
                          Get.until((route) => route.settings.name == '/game');
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildActionButton(
                        theme,
                        'exit'.tr,
                        Icons.exit_to_app,
                        () async {
                          final gameStateRepository = await ref
                              .read(gameStateRepositoryProvider.future);
                          if (gameStateRepository != null) {
                            final newGameState = gameState.value!.copyWith(
                              nullMatch: true,
                              gameStatus: GameStatus.playerSelection,
                            );
                            await gameStateRepository
                                .setGameState(newGameState);
                          }
                          Get.until((route) => route.settings.name == '/');
                        },
                      ),
                    ),
                  ],
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
          'match_statistics'.tr,
          style: theme.textStyles.titleLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideX(),
      ],
    );
  }

  Widget _buildPlayerHeader(IThemeService theme, String playerName,
      int totalRoundsWon, bool isWinner) {
    const iconSize = 24.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: iconSize.h,
          child: isWinner
              ? Icon(
                  Icons.emoji_events,
                  color: theme.colors.primaryAccent,
                  size: iconSize.w,
                ).animate().scale(delay: 500.ms)
              : null,
        ),
        SizedBox(height: 4.h),
        Text(
          '$totalRoundsWon',
          style: theme.textStyles.statValue,
        ),
        SizedBox(height: 4.h),
        Text(
          playerName,
          style: theme.textStyles.titleLarge,
        ),
      ],
    );
  }

  Widget _buildStatItem(
      IThemeService theme, String label, int player1Hits, int player2Hits,
      {bool isReverse = false}) {
    final maxHits = player1Hits > player2Hits ? player1Hits : player2Hits;
    final minHits = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = isReverse
        ? (player1Hits > 0 ? minHits / player1Hits : 1.0)
        : (maxHits > 0 ? player1Hits / maxHits : 1.0);
    final player2Percent = isReverse
        ? (player2Hits > 0 ? minHits / player2Hits : 1.0)
        : (maxHits > 0 ? player2Hits / maxHits : 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$player1Hits',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '$player2Hits',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: theme.colors.secondaryBackground.withAlpha(51),
                  borderRadius: theme.borders.primaryRadius,
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: player1Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: player2Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleStatItem(IThemeService theme, String label,
      double player1Hits, double player2Hits) {
    final maxHits = player1Hits > player2Hits ? player1Hits : player2Hits;
    final player1Percent = maxHits > 0 ? player1Hits / maxHits : 1.0;
    final player2Percent = maxHits > 0 ? player2Hits / maxHits : 1.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${player1Hits.toStringAsFixed(1)}',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${player2Hits.toStringAsFixed(1)}',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: theme.colors.secondaryBackground.withAlpha(51),
                  borderRadius: theme.borders.primaryRadius,
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: player1Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: player2Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPercentStatItem(IThemeService theme, String label,
      double player1Hits, double player2Hits) {
    final maxHits = player1Hits > player2Hits ? player1Hits : player2Hits;

    final player1Percent = maxHits > 0 ? player1Hits / maxHits : 1.0;
    final player2Percent = maxHits > 0 ? player2Hits / maxHits : 1.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${(player1Hits * 100).round()}%',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${(player2Hits * 100).round()}%',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: theme.colors.secondaryBackground.withAlpha(51),
                  borderRadius: theme.borders.primaryRadius,
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: player1Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: player2Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationStatItem(IThemeService theme, String label,
      Duration player1Hits, Duration player2Hits) {
    final minHits = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = player1Hits > Duration.zero
        ? minHits.inSeconds / player1Hits.inSeconds
        : 1.0;
    final player2Percent = player2Hits > Duration.zero
        ? minHits.inSeconds / player2Hits.inSeconds
        : 1.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${player1Hits.inMinutes.toString().padLeft(2, '0')}:${(player1Hits.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${player2Hits.inMinutes.toString().padLeft(2, '0')}:${(player2Hits.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: theme.colors.secondaryBackground.withAlpha(51),
                  borderRadius: theme.borders.primaryRadius,
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: player1Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: player2Percent,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: theme.colors.primaryAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IThemeService theme,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colors.primaryButton,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: theme.borders.buttonRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: theme.colors.accentText, size: 14.w),
          SizedBox(width: 2.w),
          Text(
            label,
            style: theme.textStyles.buttonText.copyWith(fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }
}
