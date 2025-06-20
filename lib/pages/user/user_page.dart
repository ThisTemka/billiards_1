import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:fl_chart/fl_chart.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final user = Get.arguments[0] as IUser;
    final top = Get.arguments[1] as int;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme, user, top),
                  SizedBox(height: 24.h),
                  _buildUserStats(theme, user),
                  SizedBox(height: 24.h),
                  _buildBallsChart(theme, user),
                  SizedBox(height: 24.h),
                  _buildMovesChart(theme, user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(IThemeService theme, IUser user, int top) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colors.primaryAccent),
          onPressed: () => Get.back(),
        ),
        SizedBox(width: 16.w),
        CircleAvatar(
          radius: 32.r,
          backgroundColor: theme.colors.primaryAccent,
          child: Text(
            user.name[0].toUpperCase(),
            style: theme.textStyles.headlineMedium.copyWith(
              color: theme.colors.accentText,
            ),
          ),
        ).animate().scale(),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: theme.textStyles.headlineMedium,
              ).animate().fadeIn().slideX(),
              SizedBox(height: 4.h),
              Text(
                'top'.tr + ' ${top + 1}',
                style: theme.textStyles.bodyMedium,
              ).animate().fadeIn(delay: 200.ms).slideX(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserStats(IThemeService theme, IUser user) {
    return Container(
      decoration: BoxDecoration(
        gradient: theme.gradients.cardGradient,
        borderRadius: theme.borders.cardRadius,
        boxShadow: theme.shadows.cardShadow,
        border: theme.borders.cardBorder,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'player_statistics'.tr,
              style: theme.textStyles.titleLarge,
            ).animate().fadeIn().slideX(),
            SizedBox(height: 16.h),
            _buildStatGrid(theme, user),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY();
  }

  Widget _buildStatGrid(IThemeService theme, IUser user) {
    final stats = [
      {'label': 'Rounds'.tr, 'value': user.rounds},
      {'label': 'round_wins'.tr, 'value': user.roundWins},
      {'label': 'round_loses'.tr, 'value': user.roundLoses},
      {'label': 'average_move_duration'.tr, 'value': '${user.averageMoveDuration.inMinutes.toString().padLeft(2, '0')}:${(user.averageMoveDuration.inSeconds % 60).toString().padLeft(2, '0')}'},
      {'label': 'average_move_in_line'.tr, 'value': '${user.averageMovesInLine.toStringAsFixed(1)}'},
      {'label': 'accuracy_move'.tr, 'value': '${(user.accuracyMove * 100).round()}%'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          decoration: BoxDecoration(
            gradient: theme.gradients.surfaceGradient,
            borderRadius: theme.borders.cardRadius,
            boxShadow: theme.shadows.primaryShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stat['value'].toString(),
                style: theme.textStyles.headlineSmall,
              ),
              SizedBox(height: 4.h),
              Text(
                stat['label'] as String,
                style: theme.textStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).animate().fadeIn(delay: (400 + index * 100).ms).scale();
      },
    );
  }

  Widget _buildBallsChart(IThemeService theme, IUser user) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        gradient: theme.gradients.cardGradient,
        borderRadius: theme.borders.cardRadius,
        boxShadow: theme.shadows.cardShadow,
        border: theme.borders.cardBorder,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'balls_statistics'.tr,
              style: theme.textStyles.titleLarge,
            ).animate().fadeIn().slideX(),
            SizedBox(height: 16.h),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: user.whiteBalls.toDouble(),
                      title: 'white_balls'.tr,
                      color: theme.colors.tertiaryAccent,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.blackBalls.toDouble(),
                      title: 'black_balls'.tr,
                      color: theme.colors.infoColor,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.currentBalls.toDouble(),
                      title: 'current_balls'.tr,
                      color: theme.colors.accentText,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.randomBalls.toDouble(),
                      title: 'random_balls'.tr,
                      color: theme.colors.primaryAccent,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.enemyBalls.toDouble(),
                      title: 'enemy_balls'.tr,
                      color: theme.colors.secondaryAccent,
                      radius: 80.r,
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40.r,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY();
  }

  
  Widget _buildMovesChart(IThemeService theme, IUser user) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        gradient: theme.gradients.cardGradient,
        borderRadius: theme.borders.cardRadius,
        boxShadow: theme.shadows.cardShadow,
        border: theme.borders.cardBorder,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'move_statistics'.tr,
              style: theme.textStyles.titleLarge,
            ).animate().fadeIn().slideX(),
            SizedBox(height: 16.h),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: user.errorMoves.toDouble(),
                      title: 'error_moves'.tr,
                      color: theme.colors.tertiaryAccent,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.loseMoves.toDouble(),
                      title: 'lose_moves'.tr,
                      color: theme.colors.infoColor,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.scoreMoves.toDouble(),
                      title: 'score_moves'.tr,
                      color: theme.colors.accentText,
                      radius: 80.r,
                    ),
                    PieChartSectionData(
                      value: user.simpleMoves.toDouble(),
                      title: 'simple_moves'.tr,
                      color: theme.colors.primaryAccent,
                      radius: 80.r,
                    ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 40.r,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY();
  }
}