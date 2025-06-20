import 'package:billiards/entities/game_state/i_game_state_repository.dart';

abstract interface class IGameStateSeeder {
  Future<void> seed(IGameStateRepository gameStateRepository);
}


