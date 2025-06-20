import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/user.dart';
import 'package:riverpod/riverpod.dart';

typedef IUserFactory = IUser Function({
    required String name,
    required int whiteBalls,
    required int blackBalls,
    required int currentBalls,
    required int randomBalls,
    required int enemyBalls,
    required int errorMoves,
    required int loseMoves,
    required int simpleMoves,
    required int scoreMoves,
    required int rounds,
    required int roundWins,
    required int roundLoses,
    required int moveScores,
    required int moves,
    required List<int> movesInLines,
    required List<Duration> moveDurations,
});

final userFactoryProvider = Provider<IUserFactory>((ref) {
    return ({
        required String name,
        required int whiteBalls,
        required int blackBalls,
        required int currentBalls,
        required int randomBalls,
        required int enemyBalls,
        required int errorMoves,
        required int loseMoves,
        required int simpleMoves,
        required int scoreMoves,
        required int rounds,
        required int roundWins,
        required int roundLoses,
        required int moveScores,
        required int moves,
        required List<int> movesInLines,
        required List<Duration> moveDurations,
    }) {
        return User.create(
            name: name,
            whiteBalls: whiteBalls,
            blackBalls: blackBalls,
            currentBalls: currentBalls,
            randomBalls: randomBalls,
            enemyBalls: enemyBalls,
            errorMoves: errorMoves,
            loseMoves: loseMoves,
            simpleMoves: simpleMoves,
            scoreMoves: scoreMoves,
            rounds: rounds,
            roundWins: roundWins,
            roundLoses: roundLoses,
            moveScores: moveScores,
            moves: moves,
            movesInLines: movesInLines,
            moveDurations: moveDurations,
        );
    };
});

