import 'package:billiards/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';

class GameControlsWidget extends ConsumerStatefulWidget {
  final Function(Map<String, dynamic>) onTurnComplete;

  const GameControlsWidget({
    super.key,
    required this.onTurnComplete,
  });

  @override
  ConsumerState<GameControlsWidget> createState() => GameControlsWidgetState();
}

class GameControlsWidgetState extends ConsumerState<GameControlsWidget> {
  int currentBalls = 0;
  int enemyBalls = 0;
  int randomBalls = 0;
  bool blackBall = false;
  bool whiteBall = false;
  bool touchBall = false;
  bool tableExit = false;

  void resetState() {
    setState(() {
      currentBalls = 0;
      enemyBalls = 0;
      randomBalls = 0;
      blackBall = false;
      whiteBall = false;
      touchBall = false;
      tableExit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: theme.gradients.surfaceGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.shadows.primaryShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'turn_controls'.tr,
            style: theme.textStyles.headlineMedium,
          ).animate().fadeIn(duration: 500.ms),
          SizedBox(height: 16.h),
          _buildBallControls(theme),
          SizedBox(height: 16.h),
          _buildEventControls(theme),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _submitTurn,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primaryButton,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'complete_turn'.tr,
              style: theme.textStyles.bodyLarge.copyWith(
                color: theme.colors.accentText,
              ),
            ),
          ).animate().fadeIn(duration: 500.ms),
        ],
      ),
    );
  }

  Widget _buildBallControls(IThemeService theme) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        _buildBallCounter(
          theme,
          label: 'current_balls'.tr,
          value: currentBalls,
          onIncrement: () => setState(() => currentBalls++),
          onDecrement: () => setState(() => currentBalls = (currentBalls - 1).clamp(0, 7)),
        ),
        _buildBallCounter(
          theme,
          label: 'random_balls'.tr,
          value: randomBalls,
          onIncrement: () => setState(() => randomBalls++),
          onDecrement: () => setState(() => randomBalls = (randomBalls - 1).clamp(0, 7)),
        ),
        _buildBallCounter(
          theme,
          label: 'enemy_balls'.tr,
          value: enemyBalls,
          onIncrement: () => setState(() => enemyBalls++),
          onDecrement: () => setState(() => enemyBalls = (enemyBalls - 1).clamp(0, 7)),
        ),
      ],
    );
  }

  Widget _buildBallCounter(
    IThemeService theme, {
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: theme.colors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textStyles.bodyMedium,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: theme.colors.primaryAccent),
                onPressed: onDecrement,
              ),
              Text(
                value.toString(),
                style: theme.textStyles.headlineSmall,
              ),
              IconButton(
                icon: Icon(Icons.add, color: theme.colors.primaryAccent),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventControls(IThemeService theme) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8.h,
      crossAxisSpacing: 8.w,
      childAspectRatio: 1.5,
      children: [
        _buildEventToggle(theme, 'black_ball'.tr, blackBall, (value) => setState(() => blackBall = value)),
        _buildEventToggle(theme, 'white_ball'.tr, whiteBall, (value) => setState(() => whiteBall = value)),
        _buildEventToggle(theme, 'touch_ball'.tr, touchBall, (value) => setState(() => touchBall = value)),
        _buildEventToggle(theme, 'table_exit'.tr, tableExit, (value) => setState(() => tableExit = value)),
      ],
    );
  }

  Widget _buildEventToggle(
    IThemeService theme,
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: value ? theme.colors.primaryButton : theme.colors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: value,
            onChanged: (newValue) => onChanged(newValue ?? false),
            activeColor: theme.colors.primaryAccent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: theme.textStyles.bodyMedium.copyWith(
              color: value ? theme.colors.accentText : null,
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  void _submitTurn() {
    widget.onTurnComplete({
      'currentBalls': currentBalls,
      'randomBalls': randomBalls,
      'enemyBalls': enemyBalls,
      'whiteBall': whiteBall,
      'blackBall': blackBall,
      'tableExit': tableExit,
      'touchBall': touchBall,
    });
  }
} 