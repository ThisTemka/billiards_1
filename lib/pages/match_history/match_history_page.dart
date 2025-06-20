import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:intl/intl.dart';

class MatchHistoryPage extends ConsumerWidget {
  late IMatch match;

  MatchHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    match = Get.arguments as IMatch;

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

    for (final round in match.rounds) {
      final player1Stats = round.players[0];
      final player2Stats = round.players[1];

      totalBalls1 += player1Stats.currentBalls + player1Stats.randomBalls;
      totalBalls2 += player2Stats.currentBalls + player2Stats.randomBalls;

      totalErrorMove1 += player1Stats.errorMoves;
      totalErrorMove2 += player2Stats.errorMoves;

      if (player1Stats.win) totalRoundsWon1++;
      if (player2Stats.win) totalRoundsWon2++;
    }

    totalAccuracy1 = match.rounds.fold(0, (a, b) => a + b.players[0].moveScores) / match.rounds.fold(1, (a, b) => a + b.players[0].moves);
    totalAccuracy2 = match.rounds.fold(0, (a, b) => a + b.players[1].moveScores) / match.rounds.fold(1, (a, b) => a + b.players[1].moves);

    totalMaxMoveInLine1 = match.rounds.fold(0, (a, b) => a > b.players[0].maxMoveInLine ? a : b.players[0].maxMoveInLine);
    totalMaxMoveInLine2 = match.rounds.fold(0, (a, b) => a > b.players[1].maxMoveInLine ? a : b.players[1].maxMoveInLine);
    
    totalAverageMoveInLine1 = match.rounds.fold(0, (a, b) => a + b.players[0].movesInLines.fold(0, (a, b) => a + b) / match.rounds.fold(1, (a, b) => a + b.players[0].movesInLines.length));
    totalAverageMoveInLine2 = match.rounds.fold(0, (a, b) => a + b.players[1].movesInLines.fold(0, (a, b) => a + b) / match.rounds.fold(1, (a, b) => a + b.players[1].movesInLines.length));

    totalAverageMoveDuration1 = match.rounds.fold(Duration.zero, (a, b) => a + b.players[0].moveDurations.fold(Duration.zero, (a, b) => a + b) ~/ match.rounds.fold(1, (a, b) => a + b.players[0].moveDurations.length));
    totalAverageMoveDuration2 = match.rounds.fold(Duration.zero, (a, b) => a + b.players[1].moveDurations.fold(Duration.zero, (a, b) => a + b) ~/ match.rounds.fold(1, (a, b) => a + b.players[1].moveDurations.length));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.colors.primaryBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(theme, dateFormat),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildMatchInfo(theme),
                      SizedBox(height: 24.h),
                      _buildStatisticsCard(theme, totalBalls1, totalBalls2, totalAccuracy1, totalAccuracy2, 
                        totalMaxMoveInLine1, totalMaxMoveInLine2, totalAverageMoveInLine1, totalAverageMoveInLine2,
                        totalAverageMoveDuration1, totalAverageMoveDuration2, totalErrorMove1, totalErrorMove2,
                        totalRoundsWon1, totalRoundsWon2),
                      SizedBox(height: 24.h),
                      _buildRoundsList(theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(IThemeService theme, DateFormat dateFormat) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: theme.gradients.headerGradient,
        boxShadow: theme.shadows.headerShadow,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: theme.colors.accentText,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'history'.tr,
                  style: theme.textStyles.headlineMedium.copyWith(
                    color: theme.colors.accentText,
                  ),
                ),
                // Text(
                //   dateFormat.format(match.createdAt),
                //   style: theme.textStyles.bodyMedium.copyWith(
                //     color: theme.colors.accentText.withOpacity(0.8),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchInfo(IThemeService theme) {
    return Card(
      elevation: 8,
      color: theme.colors.primaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: theme.borders.matchRadius,
        side: BorderSide(
          color: theme.colors.primaryAccent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match.users[0].name,
                        style: theme.textStyles.playerName,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${match.rounds.fold(0, (sum, round) => sum + (round.players[0].win ? 1 : 0))}',
                        style: theme.textStyles.scoreText,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: theme.gradients.scoreGradient,
                    borderRadius: theme.borders.scoreRadius,
                  ),
                  child: Text(
                    'vs'.tr,
                    style: theme.textStyles.titleLarge.copyWith(
                      color: theme.colors.accentText,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match.users[1].name,
                        style: theme.textStyles.playerName,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${match.rounds.fold(0, (sum, round) => sum + (round.players[1].win ? 1 : 0))}',
                        style: theme.textStyles.scoreText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: theme.colors.primaryAccent.withOpacity(0.1),
                borderRadius: theme.borders.scoreRadius,
              ),
              child: Text(
                '${'winner'.tr}: ${match.rounds.fold(0, (sum, round) => sum + (round.players[0].win ? 1 : 0)) > match.rounds.fold(0, (sum, round) => sum + (round.players[1].win ? 1 : 0)) ? match.users[0].name : match.users[1].name}',
                style: theme.textStyles.titleMedium.copyWith(
                  color: theme.colors.primaryAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(
    IThemeService theme,
    int totalBalls1,
    int totalBalls2,
    double totalAccuracy1,
    double totalAccuracy2,
    int totalMaxMoveInLine1,
    int totalMaxMoveInLine2,
    double totalAverageMoveInLine1,
    double totalAverageMoveInLine2,
    Duration totalAverageMoveDuration1,
    Duration totalAverageMoveDuration2,
    int totalErrorMove1,
    int totalErrorMove2,
    int totalRoundsWon1,
    int totalRoundsWon2,
  ) {
    return Card(
      elevation: 8,
      color: theme.colors.primaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: theme.borders.cardRadius,
        side: BorderSide(
          color: theme.colors.primaryAccent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'statistics'.tr,
              style: theme.textStyles.titleMedium,
            ),
            SizedBox(height: 16.h),
            _buildStatItem(theme, 'balls'.tr, totalBalls1, totalBalls2),
            _buildPercentStatItem(theme, 'accuracy'.tr, totalAccuracy1, totalAccuracy2),
            _buildStatItem(theme, 'max_move_in_line'.tr, totalMaxMoveInLine1, totalMaxMoveInLine2),
            _buildDoubleStatItem(theme, 'average_move_in_line'.tr, totalAverageMoveInLine1, totalAverageMoveInLine2),
            _buildDurationStatItem(theme, 'average_move_duration'.tr, totalAverageMoveDuration1, totalAverageMoveDuration2),
            _buildStatItem(theme, 'error_move'.tr, totalErrorMove1, totalErrorMove2, isReverse: true),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IThemeService theme, String label, int player1Hits, int player2Hits, {bool isReverse = false}) {
    final maxHits = player1Hits > player2Hits ? player1Hits : player2Hits;
    final minHits = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = isReverse ? (player1Hits > 0 ? minHits / player1Hits : 1.0) : (maxHits > 0 ? player1Hits / maxHits : 1.0);
    final player2Percent = isReverse ? (player2Hits > 0 ? minHits / player2Hits : 1.0) : (maxHits > 0 ? player2Hits / maxHits : 1.0);
    
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

  Widget _buildDoubleStatItem(IThemeService theme, String label, double player1Hits, double player2Hits) {
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

  Widget _buildPercentStatItem(IThemeService theme, String label, double player1Hits, double player2Hits) {
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
                          widthFactor: player1Percent.clamp(0, 1),
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
                          widthFactor: player2Percent.clamp(0, 1),
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

  Widget _buildDurationStatItem(IThemeService theme, String label, Duration player1Hits, Duration player2Hits) {
    final minHits = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = player1Hits > Duration.zero ? minHits.inSeconds / player1Hits.inSeconds : 1.0;
    final player2Percent = player2Hits > Duration.zero ? minHits.inSeconds / player2Hits.inSeconds : 1.0;
    
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

  Widget _buildRoundsList(IThemeService theme) {
    return Card(
      elevation: 8,
      color: theme.colors.primaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: theme.borders.cardRadius,
        side: BorderSide(
          color: theme.colors.primaryAccent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rounds'.tr,
              style: theme.textStyles.titleMedium,
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: match.rounds.length,
              itemBuilder: (context, index) {
                final round = match.rounds[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed("/round_history", arguments: {
                      'match': match,
                      'roundIndex': index,
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: theme.colors.surfaceColor,
                      borderRadius: theme.borders.playerRadius,
                      border: Border.all(
                        color: theme.colors.primaryAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'round'.tr} ${index + 1}',
                          style: theme.textStyles.titleSmall,
                        ),
                        Text(
                          round.players[0].win ? match.users[0].name : match.users[1].name,
                          style: theme.textStyles.bodyMedium.copyWith(
                            color: theme.colors.primaryAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
