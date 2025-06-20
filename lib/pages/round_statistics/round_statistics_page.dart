import 'package:billiards/entities/game_state/game_state_repository.dart';
import 'package:billiards/entities/match/match_repository.dart';
import 'package:billiards/entities/player/player_repository.dart';
import 'package:billiards/entities/round/round_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/pages/game/game_page.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:billiards/entities/player/player.dart';
import 'package:billiards/entities/game_state/game_status.dart';

class RoundStatisticsPage extends ConsumerWidget {
  const RoundStatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final gameState = ref.watch(gameStateProvider);

    if (gameState.value == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentRound = gameState.value!.currentRound!;
    final player1 = currentRound.players[0];
    final player2 = currentRound.players[1];

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
                                    theme, player1.user.name, player1.win),
                              ),
                              Expanded(
                                child: _buildPlayerHeader(
                                    theme, player2.user.name, player2.win),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            children: [
                              _buildStatItem(
                                  theme,
                                  'balls'.tr,
                                  player1.currentBalls + player1.randomBalls,
                                  player2.currentBalls + player2.randomBalls),
                              _buildPercentStatItem(theme, 'accurancy_move'.tr,
                                  player1.accuracyMove, player2.accuracyMove),
                              _buildStatItem(theme, 'max_move_in_line'.tr,
                                  player1.maxMoveInLine, player2.maxMoveInLine),
                              _buildDurationStatItem(
                                  theme,
                                  'average_move_duration'.tr,
                                  player1.averageMoveDuration,
                                  player2.averageMoveDuration),
                              _buildDoubleStatItem(
                                  theme,
                                  'average_move_in_line'.tr,
                                  player1.averageMoveInLine,
                                  player2.averageMoveInLine),
                              _buildStatItem(
                                  theme,
                                  'error_move'.tr,
                                  player1.errorMoves + player1.loseMoves,
                                  player2.errorMoves + player2.loseMoves,
                                  isReverse: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _buildActionButtons(theme, ref),
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
          'round_info'.tr,
          style: theme.textStyles.titleLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideX(),
      ],
    );
  }

  Widget _buildPlayerHeader(
      IThemeService theme, String playerName, bool isWinner) {
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
    final minDuration = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = player1Hits > Duration.zero
        ? minDuration.inSeconds / player1Hits.inSeconds
        : 1.0;
    final player2Percent = player2Hits > Duration.zero
        ? minDuration.inSeconds / player2Hits.inSeconds
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
                  '${(player1Hits.inMinutes).toString().padLeft(2, '0')}:${(player1Hits.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: theme.textStyles.statValue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '${(player2Hits.inMinutes).toString().padLeft(2, '0')}:${(player2Hits.inSeconds % 60).toString().padLeft(2, '0')}',
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

  Widget _buildActionButtons(IThemeService theme, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildActionButton(
              theme,
              'start_round'.tr,
              Icons.play_arrow,
              () async {
                final gameState = await ref.read(gameStateProvider.future);
                final currentMatch = gameState.currentMatch!;
                final round = Round.create(
                  players: [
                    Player.create(
                      user: currentMatch.users[0],
                    ),
                    Player.create(
                      user: currentMatch.users[1],
                    ),
                  ],
                  start: DateTime.now(),
                );
                final newCurrentMatch = currentMatch.copyWith(
                  rounds: [
                    ...currentMatch.rounds,
                    round,
                  ],
                );
                final playerRepository =
                    await ref.read(playerRepositoryProvider.future);
                await playerRepository.add(round.players[0]);
                await playerRepository.add(round.players[1]);
                final roundRepository =
                    await ref.read(roundRepositoryProvider.future);
                await roundRepository.add(round);
                final matchRepository =
                    await ref.read(matchRepositoryProvider.future);
                await matchRepository.refresh(newCurrentMatch);

                final gameStateRepository =
                    await ref.read(gameStateRepositoryProvider.future);
                final newGameState = gameState.copyWith(
                  currentMatch: newCurrentMatch,
                  currentRound: round,
                  gameStatus: GameStatus.roundStart,
                );
                await gameStateRepository.setGameState(newGameState);
                Get.until((route) => route.settings.name == '/game');
              },
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: _buildActionButton(
              theme,
              'view_statistics'.tr,
              Icons.bar_chart,
              () async {
                final gameState = await ref.read(gameStateProvider.future);
                final currentMatch = gameState.currentMatch!;
                final newCurrentMatch = currentMatch.copyWith(
                  end: DateTime.now(),
                );
                final matchRepository =
                    await ref.read(matchRepositoryProvider.future);
                await matchRepository.refresh(newCurrentMatch);

                final gameStateRepository =
                    await ref.read(gameStateRepositoryProvider.future);
                final newGameState = gameState.copyWith(
                  currentMatch: newCurrentMatch,
                  gameStatus: GameStatus.playerSelection,
                );
                await gameStateRepository.setGameState(newGameState);
                Get.toNamed('/gameStatistics');
              },
            ),
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
