import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/services/store/i_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User implements IEntity, IUser {
  @override
  late int id;
  @override
  final String name;

  @override
  final int whiteBalls;
  @override
  final int blackBalls;
  @override
  final int currentBalls;
  @override
  final int randomBalls;
  @override
  final int enemyBalls;
  
  @override
  final int errorMoves;
  @override
  final int loseMoves;
  @override
  final int simpleMoves;
  @override
  final int scoreMoves;

  @override
  final int rounds;
  @override
  final int roundWins;
  @override
  final int roundLoses;
  @override
  @Transient()
  double get accuracyMove => moves > 0 ? currentBalls / moves : 0;
  @override
  @Transient()
  double get averageMovesInLine => movesInLines.length > 0 ? movesInLines.reduce((a, b) => a + b) / movesInLines.length : 0;
  @override
  @Transient()
  Duration get averageMoveDuration => moveDurations.length > 0 ? Duration(seconds: moveDurations.reduce((a, b) => a + b).inSeconds ~/ moveDurations.length) : Duration.zero;
  
  @override
  final int moveScores;
  @override
  final int moves;
  @override
  final List<int> movesInLines;
  @override
  @Transient()
  List<Duration> get moveDurations => moveDurationsInSeconds.map((e) => Duration(seconds: e)).toList();
  final List<int> moveDurationsInSeconds;

  User({
    required this.id,
    required this.name,
    required this.whiteBalls,
    required this.blackBalls,
    required this.currentBalls,
    required this.randomBalls,
    required this.enemyBalls,
    required this.errorMoves,
    required this.loseMoves,
    required this.simpleMoves,
    required this.scoreMoves,
    required this.rounds,
    required this.roundWins,
    required this.roundLoses,
    required this.moveScores,
    required this.moves,
    required this.movesInLines,
    required this.moveDurationsInSeconds,
  });

  User.create({
    this.id = 0,
    required this.name,
    this.whiteBalls = 0,
    this.blackBalls = 0,
    this.currentBalls = 0,
    this.randomBalls = 0,
    this.enemyBalls = 0,
    this.errorMoves = 0,
    this.loseMoves = 0,
    this.simpleMoves = 0,
    this.scoreMoves = 0,
    this.rounds = 0,
    this.roundWins = 0,
    this.roundLoses = 0,
    this.moveScores = 0,
    this.moves = 0,
    this.movesInLines = const [],
    List<Duration>? moveDurations,
  }) : 
    moveDurationsInSeconds = moveDurations?.map((e) => e.inSeconds).toList() ?? [];

  @override
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
  }) {
    return User.create(
      id: id,
      name: name ?? this.name,
      whiteBalls: whiteBalls ?? this.whiteBalls,
      blackBalls: blackBalls ?? this.blackBalls,
      currentBalls: currentBalls ?? this.currentBalls,
      randomBalls: randomBalls ?? this.randomBalls,
      enemyBalls: enemyBalls ?? this.enemyBalls,
      errorMoves: errorMoves ?? this.errorMoves,
      loseMoves: loseMoves ?? this.loseMoves,
      simpleMoves: simpleMoves ?? this.simpleMoves,
      scoreMoves: scoreMoves ?? this.scoreMoves,
      rounds: rounds ?? this.rounds,
      roundWins: roundWins ?? this.roundWins,
      roundLoses: roundLoses ?? this.roundLoses,
      moveScores: moveScores ?? this.moveScores,
      moves: moves ?? this.moves,
      movesInLines: movesInLines ?? this.movesInLines,
      moveDurations: moveDurations ?? this.moveDurations,
    );
  }

  @override 
  int ratingCompareTo(IUser other) {
    // Сравниваем по количеству побед в раундах
    if (roundWins != other.roundWins) {
      return other.roundWins.compareTo(roundWins);
    }
    
    // При равном количестве побед сравниваем по точности ходов
    if (accuracyMove != other.accuracyMove) {
      return other.accuracyMove.compareTo(accuracyMove);
    }
    
    // При равной точности сравниваем по среднему количеству ходов в серии
    if (averageMovesInLine != other.averageMovesInLine) {
      return other.averageMovesInLine.compareTo(averageMovesInLine);
    }
    
    // При равных показателях сравниваем по количеству очков за ходы
    if (moveScores != other.moveScores) {
      return other.moveScores.compareTo(moveScores);
    }
    
    // Если все показатели равны, считаем пользователей равными
    return 0;
  }
}