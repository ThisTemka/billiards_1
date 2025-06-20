import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/services/store/i_entity.dart';

abstract interface class IPlayer implements IEntity {
  IUser get user;

  int get leftBalls;
  DateTime? get startMoveTime;
  int get currentMoveInLine;
  bool get win;

  int get moves;
  int get moveScores;
  List<Duration> get moveDurations;
  List<int> get movesInLines;

  int get errorMoves;
  int get loseMoves;
  int get simpleMoves;
  int get scoreMoves;

  int get whiteBalls;
  int get blackBalls;
  int get currentBalls;
  int get randomBalls;
  int get enemyBalls;

  int get maxMoveInLine;
  Duration get averageMoveDuration;
  double get averageMoveInLine;
  double get accuracyMove;

  IPlayer copyWith({
    IUser? user,
    int? leftBalls,
    bool nullStartMoveTime,
    DateTime? startMoveTime,
    int? currentMoveInLine,
    bool? win,
    int? moves,
    int moveScores,
    List<Duration>? moveDurations,
    List<int>? movesInLines,
    int? errorMoves,
    int? loseMoves,
    int? simpleMoves,
    int? scoreMoves,
    int? whiteBalls,
    int? blackBalls,
    int? enemyBalls,
    int? randomBalls,
    int? currentBalls,
  });
}