import 'package:billiards/entities/player/i_player_repository.dart';

abstract interface class IPlayerSeeder {
  Future<void> seed(IPlayerRepository repository);
}