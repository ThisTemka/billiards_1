import 'package:billiards/entities/game_state/i_game_state.dart';

abstract interface class IGameStateRepository {
  Future<IGameState> getGameState();
  Future<int> setGameState(IGameState gameState);
  Future<void> resetGameState();
}

