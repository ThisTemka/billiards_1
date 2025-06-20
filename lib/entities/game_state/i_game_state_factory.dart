import 'package:billiards/entities/game_state/game_state.dart';
import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/entities/game_state/i_game_state.dart';
import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:riverpod/riverpod.dart';

typedef IGameStateFactory = IGameState Function(
  {
    required IMatch? currentMatch,
    required IRound? currentRound,
    required IPlayer? currentPlayer,
    required GameStatus gameStatus,
  }
);

final gameStateFactoryProvider = Provider<IGameStateFactory>((ref) {
  return ({
    required IMatch? currentMatch,
    required IRound? currentRound,
    required IPlayer? currentPlayer,
    required GameStatus gameStatus,
  }) {
    return GameState.create(
      currentMatch: currentMatch,
      currentRound: currentRound,
      currentPlayer: currentPlayer,
      gameStatus: gameStatus,
    );
  };
});
