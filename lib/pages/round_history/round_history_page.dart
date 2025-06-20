import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:fl_chart/fl_chart.dart';

class RoundHistoryPage extends ConsumerWidget {
  late IMatch match;
  late int roundIndex;

  RoundHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final args = Get.arguments as Map<String, dynamic>;
    match = args['match'] as IMatch;
    roundIndex = args['roundIndex'] as int;
    final round = match.rounds[roundIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.colors.primaryBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(theme),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildRoundInfo(theme, round),
                      SizedBox(height: 24.h),
                      _buildTurnsList(theme, round),
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

  Widget _buildHeader(IThemeService theme) {
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
            child: Text(
              '${'round'.tr} ${roundIndex + 1}',
              style: theme.textStyles.headlineMedium.copyWith(
                color: theme.colors.accentText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundInfo(IThemeService theme, dynamic round) {
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
                        '${round.players[0].win ? 1 : 0}',
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
                        '${round.players[1].win ? 1 : 0}',
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
                color: theme.colors.primaryAccent.withAlpha(25),
                borderRadius: theme.borders.scoreRadius,
              ),
              child: Text(
                '${'winner'.tr}: ${round.players[0].win ? match.users[0].name : match.users[1].name}',
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


  Widget _buildTurnsList(IThemeService theme, dynamic round) {
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
            _buildStatItem(theme, 'balls'.tr, round.players[0].currentBalls + round.players[0].randomBalls, round.players[1].currentBalls + round.players[1].randomBalls),
            _buildPercentStatItem(theme, 'accurancy_move'.tr, round.players[0].accuracyMove, round.players[1].accuracyMove),
            _buildStatItem(theme, 'max_move_in_line'.tr, round.players[0].maxMoveInLine, round.players[1].maxMoveInLine),
            _buildDurationStatItem(theme, 'average_move_duration'.tr, round.players[0].averageMoveDuration, round.players[1].averageMoveDuration),
            _buildDoubleStatItem(theme, 'average_move_in_line'.tr, round.players[0].averageMoveInLine, round.players[1].averageMoveInLine),
            _buildStatItem(theme, 'error_move'.tr, round.players[0].errorMoves, round.players[1].errorMoves, isReverse: true),
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

  Widget _buildDurationStatItem(IThemeService theme, String label, Duration player1Hits, Duration player2Hits) {
    final minDuration = player1Hits < player2Hits ? player1Hits : player2Hits;
    final player1Percent = player1Hits > Duration.zero ? minDuration.inSeconds / player1Hits.inSeconds : 1.0;
    final player2Percent = player2Hits > Duration.zero ? minDuration.inSeconds / player2Hits.inSeconds : 1.0;
    
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
}