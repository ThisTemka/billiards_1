import 'package:billiards/services/store/i_entity.dart';

abstract interface class IUser implements IEntity {
  String get name;
  
  int get whiteBalls;
  int get blackBalls;
  int get currentBalls;
  int get randomBalls;
  int get enemyBalls;

  int get errorMoves;
  int get loseMoves;
  int get simpleMoves;
  int get scoreMoves;

  int get rounds;
  int get roundWins;
  int get roundLoses;
  double get accuracyMove;
  double get averageMovesInLine;
  Duration get averageMoveDuration;

  int get moveScores;
  int get moves;
  List<int> get movesInLines;
  List<Duration> get moveDurations;

  IUser copyWith({
    String? name,

    int? whiteBalls,
    int? blackBalls,
    int? currentBalls,
    int? randomBalls,
    int? enemyBalls,

    int? errorMoves,
    int? loseMoves,
    int? simpleMoves,
    int? scoreMoves,

    int? rounds,
    int? roundWins,
    int? roundLoses,
    int? moveScores,
    int? moves,
    List<int>? movesInLines,
    List<Duration>? moveDurations,
  });

  int ratingCompareTo(IUser other);
}