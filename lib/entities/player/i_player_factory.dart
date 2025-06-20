import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/player/player.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:riverpod/riverpod.dart';

typedef IPlayerFactory = IPlayer Function({
    required IUser user,
    required int leftBalls,
    DateTime? startMoveTime,
    required int currentMoveInLine,
    required bool win,
    required int moves,
    required int moveScores,
    required List<Duration> moveDurations,
    required List<int> movesInLines,
    required int errorMoves,
    required int loseMoves,
    required int simpleMoves,
    required int scoreMoves,
    required int whiteBalls,
    required int blackBalls,
    required int enemyBalls,
    required int randomBalls,
    required int currentBalls,
});

final playerFactoryProvider = Provider<IPlayerFactory>((ref) {
  return ({
    required IUser user,
    required int leftBalls,
    DateTime? startMoveTime,
    required int currentMoveInLine,
    required bool win,
    required int moves,
    required int moveScores,
    required List<Duration> moveDurations,
    required List<int> movesInLines,
    required int errorMoves,
    required int loseMoves,
    required int simpleMoves,
    required int scoreMoves,
    required int whiteBalls,
    required int blackBalls,
    required int enemyBalls,
    required int randomBalls,
    required int currentBalls,
  }) {
    return Player.create(
      user: user,
      leftBalls: leftBalls,
      startMoveTime: startMoveTime,
      currentMoveInLine: currentMoveInLine,
      win: win,
      moves: moves,
      moveScores: moveScores,
      moveDurations: moveDurations,
      movesInLines: movesInLines,
      errorMoves: errorMoves,
      loseMoves: loseMoves,
      simpleMoves: simpleMoves,
      scoreMoves: scoreMoves,
      whiteBalls: whiteBalls,
      blackBalls: blackBalls,
      enemyBalls: enemyBalls,
      randomBalls: randomBalls,
      currentBalls: currentBalls,
    );
  };
});