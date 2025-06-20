import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/entities/game_state/i_game_state.dart';
import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/match/match.dart';
import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/player/player.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class GameState implements IGameState {
  @override
  int id;
  @override
  @Transient()
  IMatch? get currentMatch => rcurrentMatch.target;
  ToOne<Match> rcurrentMatch;
  @override
  @Transient()
  IRound? get currentRound => rcurrentRound.target;
  ToOne<Round> rcurrentRound;
  @override
  @Transient()
  IPlayer? get currentPlayer => rcurrentPlayer.target;
  ToOne<Player> rcurrentPlayer;
  @override
  @Transient()
  GameStatus get gameStatus => GameStatus.values[gameStatusIndex];
  final int gameStatusIndex;

  GameState({
    this.id = 0,
    required this.rcurrentMatch,
    required this.rcurrentRound,
    required this.rcurrentPlayer,
    required this.gameStatusIndex,
  });

  GameState.create({
    this.id = 0,
    required IMatch? currentMatch,
    required IRound? currentRound,
    required IPlayer? currentPlayer,
    GameStatus gameStatus = GameStatus.playerSelection,
  }) : 
    rcurrentMatch = ToOne<Match>(target: currentMatch as Match?),
    rcurrentRound = ToOne<Round>(target: currentRound as Round?),
    rcurrentPlayer = ToOne<Player>(target: currentPlayer as Player?),
    gameStatusIndex = gameStatus.index;

  @override
  IGameState copyWith({
    bool nullMatch = false,
    bool nullRound = false,
    bool nullPlayer = false,
    IMatch? currentMatch,
    IRound? currentRound,
    IPlayer? currentPlayer,
    GameStatus? gameStatus,
  }) {
    return GameState.create(
      id: id,
      currentMatch: nullMatch ? null : currentMatch ?? this.currentMatch,
      currentRound: nullRound ? null : currentRound ?? this.currentRound,
      currentPlayer: nullPlayer ? null : currentPlayer ?? this.currentPlayer,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}
