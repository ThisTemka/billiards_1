import 'package:billiards/entities/match/match_repository.dart';
import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/player/player_repository.dart';
import 'package:billiards/entities/round/round_repository.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/user_repository.dart';
import 'package:billiards/entities/game_state/i_game_state.dart';
import 'package:billiards/entities/game_state/game_state_repository.dart';
import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/pages/game/player_turn_selection/player_turn_selection_widget.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/entities/match/match.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:billiards/entities/player/player.dart';
import 'package:billiards/pages/game/player_selection/player_selection_widget.dart';
import 'package:billiards/pages/game/game_controls/game_controls_widget.dart';
import 'package:billiards/pages/game/player_stats/player_stats_widget.dart';

final gameStateProvider = FutureProvider<IGameState>((ref) async {
  ref.watch(gameStateRepositoryProvider);
  final gameStateRepository =
      await ref.watch(gameStateRepositoryProvider.future);
  final gameState = await gameStateRepository.getGameState();
  return gameState;
});

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  final ScrollController _scrollController = ScrollController();
  final _gameControlsKey = GlobalKey<GameControlsWidgetState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final gameState = ref.watch(gameStateProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.gradients.surfaceGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildHeader(ref, theme),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: _buildGameContent(
                        ref, theme, gameState.value?.gameStatus),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(WidgetRef ref, IThemeService theme) {
    final gameState = ref.watch(gameStateProvider);
    final currentGameStatus = gameState.value?.gameStatus;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: theme.gradients.headerGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.shadows.primaryShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: theme.colors.accentText),
                onPressed: () => Get.toNamed('/'),
                color: theme.colors.primaryText,
              ),
              if (currentGameStatus == GameStatus.playerTurn ||
                  currentGameStatus == GameStatus.roundStart)
                IconButton(
                  icon: Icon(Icons.stop_circle_outlined,
                      color: theme.colors.errorColor),
                  onPressed: () => _stopGame(ref),
                  tooltip: 'stop_game'.tr,
                ),
            ],
          ),
          Text(
            'round'.tr,
            style: theme.textStyles.headlineMedium
                .copyWith(color: theme.colors.accentText),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: theme.colors.accentText),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildGameContent(
      WidgetRef ref, IThemeService theme, GameStatus? gameStatus) {
    switch (gameStatus) {
      case null:
        return const SizedBox.shrink();
      case GameStatus.playerSelection:
        return PlayerSelectionWidget(
          onPlayersSelected: (user1, user2) async {
            await _startNewMatch(ref, user1, user2);
            await _startNewRound(ref);
          },
        );
      case GameStatus.roundStart:
        return PlayerTurnSelectionWidget(
          onPlayerTurnSelected: (player) async {
            await _selectPlayer(ref, player);
          },
        );
      case GameStatus.playerTurn:
        return Column(
          children: [
            PlayerStatsWidget(),
            SizedBox(height: 16.h),
            GameControlsWidget(
              key: _gameControlsKey,
              onTurnComplete: (stats) async {
                await _handleTurnComplete(ref, stats);
              },
            ),
          ],
        );
    }
  }

  Future<void> _startNewMatch(WidgetRef ref, IUser user1, IUser user2) async {
    final match = Match.create(
      users: [user1, user2],
      rounds: [],
      start: DateTime.now(),
    );
    final matchRepository = await ref.read(matchRepositoryProvider.future);
    await matchRepository.add(match);

    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    final currentGameState = await gameStateRepository.getGameState();
    final newGameState = currentGameState.copyWith(
      currentMatch: match,
    );
    await gameStateRepository.setGameState(newGameState);
  }

  Future<void> _startNewRound(WidgetRef ref) async {
    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    final gameState = await gameStateRepository.getGameState();
    final currentMatch = gameState.currentMatch!;

    final playerRepository = await ref.read(playerRepositoryProvider.future);

    final player1 = Player.create(
      user: currentMatch.users[0],
    );
    await playerRepository.add(player1);

    final player2 = Player.create(
      user: currentMatch.users[1],
    );
    await playerRepository.add(player2);

    final roundRepository = await ref.read(roundRepositoryProvider.future);
    final round = Round.create(
      players: [
        player1,
        player2,
      ],
      start: DateTime.now(),
    );
    await roundRepository.add(round);

    final matchRepository = await ref.read(matchRepositoryProvider.future);
    final newCurrentMatch = currentMatch.copyWith(
      rounds: [
        round,
      ],
    );
    await matchRepository.refresh(newCurrentMatch);

    final newGameState = gameState.copyWith(
      currentMatch: newCurrentMatch,
      currentRound: round,
      gameStatus: GameStatus.roundStart,
    );
    await gameStateRepository.setGameState(newGameState);
  }

  Future<void> _selectPlayer(WidgetRef ref, IPlayer player) async {
    final gameState = await ref.read(gameStateProvider.future);
    final newPlayer = player.copyWith(
      startMoveTime: DateTime.now(),
    );
    final playerRepository = await ref.read(playerRepositoryProvider.future);
    await playerRepository.refresh(newPlayer);

    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    final newGameState = gameState.copyWith(
      currentPlayer: newPlayer,
      gameStatus: GameStatus.playerTurn,
    );
    await gameStateRepository.setGameState(newGameState);
  }

  Future<void> _handleTurnComplete(
      WidgetRef ref, Map<String, dynamic> stats) async {
    await _updatePlayerStats(ref, stats);
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _gameControlsKey.currentState?.resetState();
    await _nextTurn(ref, stats);
  }

  Future<void> _updatePlayerStats(
      WidgetRef ref, Map<String, dynamic> stats) async {
    final gameState = await ref.read(gameStateProvider.future);
    final currentRound = gameState.currentRound!;
    final currentPlayer = gameState.currentPlayer!;

    final playerRepository = await ref.read(playerRepositoryProvider.future);
    final matchRepository = await ref.read(matchRepositoryProvider.future);

    final currentBalls = stats['currentBalls'] as int;
    final randomBalls = stats['randomBalls'] as int;
    final enemyBalls = stats['enemyBalls'] as int;
    final whiteBalls = stats['whiteBall'] as bool ? 1 : 0;
    final blackBalls = stats['blackBall'] as bool ? 1 : 0;

    final tableExit = stats['tableExit'] as bool ? 1 : 0;
    final touchBall = stats['touchBall'] as bool ? 1 : 0;

    final loseMove = blackBalls > 0 ? 1 : 0;
    final errorMove = loseMove == 0 &&
            (whiteBalls > 0 ||
                tableExit > 0 ||
                (touchBall == 0 && (currentBalls + randomBalls) == 0))
        ? 1
        : 0;
    final scoreMove =
        errorMove == 0 && loseMove == 0 && (currentBalls + randomBalls > 0)
            ? 1
            : 0;
    final simpleMove =
        scoreMove == 0 && errorMove == 0 && loseMove == 0 ? 1 : 0;

    final move = 1;
    final moveScore = currentBalls + randomBalls;
    final moveDuration =
        DateTime.now().difference(currentPlayer.startMoveTime!);
    final movesInLine = moveScore > 0 ? currentPlayer.currentMoveInLine + 1 : 0;

    final enemyPlayer =
        currentRound.players.firstWhere((p) => p.id != currentPlayer.id);
    final newEnemyPlayer = enemyPlayer.copyWith(
      leftBalls: enemyPlayer.leftBalls - enemyBalls,
      win: blackBalls == 1 || (enemyPlayer.leftBalls - enemyBalls) == 0,
    );
    await playerRepository.refresh(newEnemyPlayer);

    final currentUser = currentPlayer.user;
    final userRepository = await ref.read(userRepositoryProvider.future);
    final newCurrentUser = currentUser.copyWith(
      currentBalls: currentUser.currentBalls + currentBalls,
      randomBalls: currentUser.randomBalls + randomBalls,
      enemyBalls: currentUser.enemyBalls + enemyBalls,
      whiteBalls: currentUser.whiteBalls + whiteBalls,
      blackBalls: currentUser.blackBalls + blackBalls,
      moves: currentUser.moves + move,
      moveScores: currentUser.moveScores + moveScore,
      moveDurations: [...currentUser.moveDurations, moveDuration],
      movesInLines: [...currentUser.movesInLines, movesInLine],
      errorMoves: currentUser.errorMoves + errorMove,
      loseMoves: currentUser.loseMoves + loseMove,
      simpleMoves: currentUser.simpleMoves + simpleMove,
      scoreMoves: currentUser.scoreMoves + scoreMove,
      roundWins: currentUser.roundWins +
          ((currentPlayer.leftBalls - (currentBalls + randomBalls)) == 0
              ? 1
              : 0),
      roundLoses: currentUser.roundLoses +
          (blackBalls == 1 || newEnemyPlayer.leftBalls == 0 ? 1 : 0),
      rounds: currentPlayer.leftBalls - (currentBalls + randomBalls) == 0 ||
              blackBalls == 1 ||
              newEnemyPlayer.leftBalls == 0
          ? currentUser.rounds + 1
          : currentUser.rounds,
    );
    await userRepository.refresh(newCurrentUser);

    final newCurrentPlayer = currentPlayer.copyWith(
      user: newCurrentUser,
      leftBalls: currentPlayer.leftBalls - (currentBalls + randomBalls),
      randomBalls: currentPlayer.randomBalls + randomBalls,
      currentBalls: currentPlayer.currentBalls + currentBalls,
      enemyBalls: currentPlayer.enemyBalls + enemyBalls,
      whiteBalls: currentPlayer.whiteBalls + whiteBalls,
      blackBalls: currentPlayer.blackBalls + blackBalls,
      moves: currentPlayer.moves + move,
      moveScores: currentPlayer.moveScores + moveScore,
      moveDurations: [...currentPlayer.moveDurations, moveDuration],
      movesInLines: movesInLine == 0
          ? [...currentPlayer.movesInLines, currentPlayer.currentMoveInLine]
          : currentPlayer.movesInLines,
      errorMoves: currentPlayer.errorMoves + errorMove,
      loseMoves: currentPlayer.loseMoves + loseMove,
      simpleMoves: currentPlayer.simpleMoves + simpleMove,
      scoreMoves: currentPlayer.scoreMoves + scoreMove,
      startMoveTime: null,
      currentMoveInLine: movesInLine,
      win: (currentPlayer.leftBalls - (currentBalls + randomBalls)) == 0,
    );
    await playerRepository.refresh(newCurrentPlayer);

    final newEnemyUser = enemyPlayer.user.copyWith(
      rounds: (newEnemyPlayer.leftBalls) == 0 ||
              blackBalls == 1 ||
              (newCurrentPlayer.leftBalls) == 0
          ? enemyPlayer.user.rounds + 1
          : enemyPlayer.user.rounds,
      roundWins: enemyPlayer.user.roundWins +
          (blackBalls == 1 || newEnemyPlayer.leftBalls == 0 ? 1 : 0),
      roundLoses: enemyPlayer.user.roundLoses +
          ((newCurrentPlayer.leftBalls) == 0 ? 1 : 0),
    );
    await userRepository.refresh(newEnemyUser);

    final roundRepository = await ref.read(roundRepositoryProvider.future);
    final newCurrentRound = currentRound.copyWith(
      players: [
        newEnemyPlayer,
        newCurrentPlayer,
      ],
    );
    await roundRepository.refresh(newCurrentRound);

    final currentMatch = gameState.currentMatch!;
    final newCurrentMatch = currentMatch.copyWith(
      rounds: [
        ...currentMatch.rounds.where((r) => r != currentRound),
        newCurrentRound,
      ],
      users: [
        ...currentMatch.users.where((u) => u.id != currentUser.id),
        newCurrentUser,
      ],
    );
    await matchRepository.refresh(newCurrentMatch);

    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    final newGameState = gameState.copyWith(
      currentMatch: newCurrentMatch,
      currentRound: newCurrentRound,
      currentPlayer: newCurrentPlayer,
    );
    await gameStateRepository.setGameState(newGameState);
  }

  Future<void> _stopGame(WidgetRef ref) async {
    final gameStateRepository =
        await ref.read(gameStateRepositoryProvider.future);
    await gameStateRepository.resetGameState();
    if (mounted) {
      Get.offAllNamed('/');
    }
  }

  Future<void> _nextTurn(WidgetRef ref, Map<String, dynamic> stats) async {
    final gameState = await ref.read(gameStateProvider.future);
    final currentRound = gameState.currentRound!;
    final currentPlayer = gameState.currentPlayer!;
    final enemyPlayer =
        currentRound.players.firstWhere((p) => p.id != currentPlayer.id);

    if (currentPlayer.win || enemyPlayer.win) {
      final newCurrentRound = currentRound.copyWith(
        end: DateTime.now(),
      );
      final roundRepository = await ref.read(roundRepositoryProvider.future);
      await roundRepository.refresh(newCurrentRound);

      final currentMatch = gameState.currentMatch!;
      final newCurrentMatch = currentMatch.copyWith(
        rounds: [
          ...currentMatch.rounds.where((r) => r != currentRound),
          newCurrentRound,
        ],
      );
      final matchRepository = await ref.read(matchRepositoryProvider.future);
      await matchRepository.refresh(newCurrentMatch);

      final gameStateRepository =
          await ref.read(gameStateRepositoryProvider.future);
      final newGameState = gameState.copyWith(
        currentMatch: newCurrentMatch,
        currentRound: newCurrentRound,
        gameStatus: GameStatus.playerSelection,
      );
      await gameStateRepository.setGameState(newGameState);

      Get.toNamed('/roundStatistics');
    } else {
      if ((stats['currentBalls'] == 0 && stats['randomBalls'] == 0) ||
          stats['whiteBall'] ||
          stats['tableExit']) {
        _selectPlayer(ref, enemyPlayer);
      } else {
        _selectPlayer(ref, currentPlayer);
      }
    }
  }
}
