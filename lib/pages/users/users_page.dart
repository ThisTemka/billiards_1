import 'package:billiards/entities/game_state/game_state_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/entities/user/user_repository.dart';
import 'package:billiards/entities/user/i_user.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final usersAsync = ref.watch(userRepositoryProvider);

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
                  child: usersAsync.when(
                    data: (repository) => FutureBuilder<List<IUser>>(
                      future: repository.getAll(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: theme.colors.primaryAccent,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'error_loading_users'.tr,
                              style: theme.textStyles.bodyMedium,
                            ),
                          );
                        }

                        final users = snapshot.data ?? [];
                        final sortedUsers = [...users]
                          ..sort((a, b) => a.ratingCompareTo(b));

                        if (users.isEmpty) {
                          return Center(
                            child: Text(
                              'no_users'.tr,
                              style: theme.textStyles.bodyMedium,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: sortedUsers.length,
                          itemBuilder: (context, index) {
                            final user = sortedUsers[index];
                            return _buildUserCard(
                                context, ref, theme, user, index, index);
                          },
                        );
                      },
                    ),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: theme.colors.primaryAccent,
                      ),
                    ),
                    error: (error, stack) => Center(
                      child: Text(
                        'error_loading_users'.tr,
                        style: theme.textStyles.bodyMedium,
                      ),
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
          'users'.tr,
          style: theme.textStyles.titleLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideX(),
      ],
    );
  }

  Future<void> _deleteUser(
      BuildContext context, WidgetRef ref, IUser user) async {
    final repository = await ref.read(userRepositoryProvider.future);
    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    if ((await gameStateRepository.getGameState())
            .currentMatch
            ?.users
            .contains(user) ??
        false) {
      await gameStateRepository.resetGameState();
    }
    await repository.delete(user.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('user_deleted'.tr)),
      );
    }
  }

  Widget _buildUserCard(BuildContext context, WidgetRef ref,
      IThemeService theme, IUser user, int index, int top) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.cardGradient,
          borderRadius: theme.borders.cardRadius,
          boxShadow: theme.shadows.cardShadow,
          border: theme.borders.cardBorder,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              // Header with delete button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: theme.colors.primaryAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(theme.borders.cardRadius.topLeft.x),
                    topRight:
                        Radius.circular(theme.borders.cardRadius.topRight.x),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'top'.tr + ' ${top + 1}',
                      style: theme.textStyles.bodyMedium,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, size: 20.w),
                      color: theme.colors.errorColor,
                      onPressed: () => _deleteUser(context, ref, user),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // User content
              InkWell(
                onTap: () => Get.toNamed('/user', arguments: [user, top]),
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(theme.borders.cardRadius.bottomLeft.x),
                  bottomRight:
                      Radius.circular(theme.borders.cardRadius.bottomRight.x),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: theme.colors.primaryAccent,
                            child: Text(
                              user.name[0].toUpperCase(),
                              style: theme.textStyles.titleLarge.copyWith(
                                color: theme.colors.accentText,
                              ),
                            ),
                          ).animate().scale(delay: (50 * index).ms),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              user.name,
                              style: theme.textStyles.titleMedium,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: theme.colors.primaryAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildStatRow(
                        theme,
                        [
                          _buildStatItem(theme, 'Rounds'.tr, user.rounds),
                          _buildStatItem(
                              theme, 'round_wins'.tr, user.roundWins),
                          _buildStatItem(
                              theme, 'round_loses'.tr, user.roundLoses),
                          _buildDurationStatItem(
                              theme,
                              'average_move_duration'.tr,
                              user.averageMoveDuration),
                          _buildDoubleStatItem(theme, 'average_move_in_line'.tr,
                              user.averageMovesInLine),
                          _buildDoubleStatItem(
                              theme, 'accuracy_move'.tr, user.accuracyMove),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: (100 * index).ms).slideX(),
    );
  }

  Widget _buildStatRow(IThemeService theme, List<Widget> items) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2,
      children: items,
    );
  }

  Widget _buildStatItem(IThemeService theme, String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: theme.textStyles.statValue,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: theme.textStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDoubleStatItem(IThemeService theme, String label, double value) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(1),
          style: theme.textStyles.statValue,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: theme.textStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDurationStatItem(
      IThemeService theme, String label, Duration value) {
    return Column(
      children: [
        Text(
          '${value.inMinutes.toString().padLeft(2, '0')}:${(value.inSeconds % 60).toString().padLeft(2, '0')}',
          style: theme.textStyles.statValue,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: theme.textStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
