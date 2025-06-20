import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Player implements IPlayer {
  @override
  late int id;
  @override
  @Transient()
  IUser get user => ruser.target!;
  final ToOne<User> ruser;

  @override
  final int leftBalls;
  @override
  final DateTime? startMoveTime;
  @override
  final int currentMoveInLine;
  @override
  final bool win;

  @override
  final int moves;
  @override
  final int moveScores;
  @override
  @Transient()
  List<Duration> get moveDurations =>
      moveDurationsInSeconds.map((e) => Duration(seconds: e)).toList();
  final List<int> moveDurationsInSeconds;
  @override
  final List<int> movesInLines;

  @override
  final int errorMoves;
  @override
  final int loseMoves;
  @override
  final int simpleMoves;
  @override
  final int scoreMoves;

  @override
  final int whiteBalls;
  @override
  final int blackBalls;
  @override
  final int enemyBalls;
  @override
  final int randomBalls;
  @override
  final int currentBalls;

  @override
  @Transient()
  int get maxMoveInLine => movesInLines.isNotEmpty
      ? movesInLines.reduce((a, b) => a > b ? a : b)
      : 0;
  @override
  @Transient()
  Duration get averageMoveDuration => moveDurations.isNotEmpty
      ? Duration(
          seconds: moveDurations.reduce((a, b) => a + b).inSeconds ~/
              moveDurations.length)
      : Duration.zero;
  @override
  @Transient()
  double get averageMoveInLine => movesInLines.isNotEmpty
      ? movesInLines.reduce((a, b) => a + b) / movesInLines.length
      : 0;
  @override
  @Transient()
  double get accuracyMove => moves > 0 ? currentBalls / moves : 0;

  Player({
    required this.id,
    required this.ruser,
    required this.leftBalls,
    required this.startMoveTime,
    required this.currentMoveInLine,
    required this.win,
    required this.moves,
    required this.moveScores,
    required this.moveDurationsInSeconds,
    required this.movesInLines,
    required this.errorMoves,
    required this.loseMoves,
    required this.simpleMoves,
    required this.scoreMoves,
    required this.whiteBalls,
    required this.blackBalls,
    required this.enemyBalls,
    required this.randomBalls,
    required this.currentBalls,
  });

  @Transient()
  Player.create({
    this.id = 0,
    required IUser user,
    this.leftBalls = 8,
    this.startMoveTime,
    this.currentMoveInLine = 0,
    this.win = false,
    this.moves = 0,
    this.moveScores = 0,
    List<Duration>? moveDurations,
    this.movesInLines = const [],
    this.errorMoves = 0,
    this.loseMoves = 0,
    this.simpleMoves = 0,
    this.scoreMoves = 0,
    this.whiteBalls = 0,
    this.blackBalls = 0,
    this.enemyBalls = 0,
    this.randomBalls = 0,
    this.currentBalls = 0,
  })  : ruser = ToOne(target: user as User),
        moveDurationsInSeconds =
            moveDurations?.map((e) => e.inSeconds).toList() ?? [];

  @override
  IPlayer copyWith({
    IUser? user,
    int? leftBalls,
    bool nullStartMoveTime = false,
    DateTime? startMoveTime,
    int? currentMoveInLine,
    bool? win,
    int? moves,
    int? moveScores,
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
  }) {
    return Player.create(
      id: id,
      user: user ?? this.user,
      leftBalls: leftBalls ?? this.leftBalls,
      startMoveTime:
          nullStartMoveTime ? null : startMoveTime ?? this.startMoveTime,
      currentMoveInLine: currentMoveInLine ?? this.currentMoveInLine,
      win: win ?? this.win,
      moves: moves ?? this.moves,
      moveScores: moveScores ?? this.moveScores,
      moveDurations: moveDurations ?? this.moveDurations,
      movesInLines: movesInLines ?? this.movesInLines,
      errorMoves: errorMoves ?? this.errorMoves,
      loseMoves: loseMoves ?? this.loseMoves,
      simpleMoves: simpleMoves ?? this.simpleMoves,
      scoreMoves: scoreMoves ?? this.scoreMoves,
      whiteBalls: whiteBalls ?? this.whiteBalls,
      blackBalls: blackBalls ?? this.blackBalls,
      enemyBalls: enemyBalls ?? this.enemyBalls,
      randomBalls: randomBalls ?? this.randomBalls,
      currentBalls: currentBalls ?? this.currentBalls,
    );
  }
}
