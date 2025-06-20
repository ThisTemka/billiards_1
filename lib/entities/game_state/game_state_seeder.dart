import 'package:billiards/entities/game_state/game_status.dart';
import 'package:billiards/entities/game_state/i_game_state.dart';
import 'package:billiards/entities/game_state/i_game_state_repository.dart';
import 'package:billiards/entities/game_state/i_game_state_seeder.dart';
import 'package:riverpod/riverpod.dart';

final gameStateSeederProvider = Provider<IGameStateSeeder>((ref) {
  return GameStateSeeder();
});

class GameStateSeeder implements IGameStateSeeder {

  GameStateSeeder();

  Future<IGameState> _createGameState(IGameState gameState) async {
    final newGameState = gameState.copyWith(
      currentMatch: null,
      currentRound: null,
      currentPlayer: null,
      gameStatus: GameStatus.playerSelection,
    );
    return newGameState;
  }


  @override
  Future<void> seed(IGameStateRepository gameStateRepository) async {
    final gameState = await gameStateRepository.getGameState();
    final newGameState = await _createGameState(gameState);
    await gameStateRepository.setGameState(newGameState);
  }
}

