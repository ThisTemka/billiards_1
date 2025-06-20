import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/match/match_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:intl/intl.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  late Future<List<IMatch>> _matchesFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(matchRepositoryProvider);
    ;
    setState(() {
      _matchesFuture = ref
          .read(matchRepositoryProvider.future)
          .then((repository) => repository.getAll());
    });
    final theme = ref.watch(themeServiceProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.surfaceGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  'history'.tr,
                  style: theme.textStyles.headlineLarge,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<IMatch>>(
                  future: _matchesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'error_loading_matches'.tr,
                              style: theme.textStyles.bodyLarge.copyWith(
                                color: theme.colors.errorColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => setState(() {
                                _matchesFuture = ref
                                    .read(matchRepositoryProvider.future)
                                    .then((repository) => repository.getAll());
                              }),
                              child: Text('retry'.tr),
                            ),
                          ],
                        ),
                      );
                    }

                    final matches = snapshot.data ?? [];
                    final sortedMatches = matches
                        .where((match) =>
                            match.end != null && match.users.length == 2)
                        .toList()
                      ..sort((a, b) => b.start.compareTo(a.start));
                    if (sortedMatches.isEmpty) {
                      return Center(
                        child: Text(
                          'no_matches'.tr,
                          style: theme.textStyles.bodyLarge,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _matchesFuture = ref
                              .read(matchRepositoryProvider.future)
                              .then((repository) => repository.getAll());
                        });
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: sortedMatches.length,
                        itemBuilder: (context, index) {
                          final match = sortedMatches[index];
                          return _MatchCard(match: match)
                              .animate()
                              .fadeIn(duration: 300.ms)
                              .slideX(begin: 0.2, end: 0);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchCard extends ConsumerWidget {
  final IMatch match;

  const _MatchCard({required this.match});

  Future<void> _deleteMatch(BuildContext context, WidgetRef ref) async {
    final repository = await ref.read(matchRepositoryProvider.future);
    await repository.delete(match.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('match_deleted'.tr)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 8,
      color: theme.colors.primaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: theme.colors.primaryAccent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with date and delete button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
            decoration: BoxDecoration(
              color: theme.colors.primaryAccent.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(match.start),
                  style: theme.textStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colors.primaryAccent,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20.w),
                  color: theme.colors.errorColor,
                  onPressed: () => _deleteMatch(context, ref),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
          // Match content
          InkWell(
            onTap: () {
              Get.toNamed("/match_history", arguments: match);
            },
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.r),
              bottomRight: Radius.circular(14.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rounds counter
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: theme.colors.primaryAccent,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${match.rounds.length} ${'rounds'.tr}',
                        style: theme.textStyles.labelText,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              match.users[0].name,
                              style: theme.textStyles.titleMedium,
                            ),
                            Text(
                              '${match.rounds.fold(0, (sum, round) => sum + (round.players[0].win ? 1 : 0))}',
                              style: theme.textStyles.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'VS',
                        style: theme.textStyles.titleLarge,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              match.users[1].name,
                              style: theme.textStyles.titleMedium,
                            ),
                            Text(
                              '${match.rounds.fold(0, (sum, round) => sum + (round.players[1].win ? 1 : 0))}',
                              style: theme.textStyles.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.primaryAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${'winner'.tr}: ${match.rounds.fold(0, (sum, round) => sum + (round.players[0].win ? 1 : 0)) > match.rounds.fold(0, (sum, round) => sum + (round.players[1].win ? 1 : 0)) ? match.users[0].name : match.users[1].name}',
                          style: theme.textStyles.labelText.copyWith(
                            color: theme.colors.primaryAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
