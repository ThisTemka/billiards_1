import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/player/i_player_factory.dart';
import 'package:billiards/entities/player/i_player_repository.dart';
import 'package:billiards/entities/player/i_player_seeder.dart';
import 'package:billiards/entities/user/i_user_repository.dart';
import 'package:billiards/entities/user/user_repository.dart';
import 'package:riverpod/riverpod.dart';

final playerSeederProvider = FutureProvider.autoDispose<IPlayerSeeder>((ref) async {
  final userRepository = await ref.read(userRepositoryProvider.future);
  final factory = ref.read(playerFactoryProvider);
  return PlayerSeeder(factory, userRepository);
});

class PlayerSeeder implements IPlayerSeeder { 
  final IPlayerFactory _factory;
  final IUserRepository _userRepository;

  PlayerSeeder(this._factory, this._userRepository);

  Future<List<IPlayer>> _generate() async {
    final users = await _userRepository.getAll();
    return [
      _factory(
        user: users[0],
        leftBalls: 0,
        startMoveTime: DateTime.now(),
        currentMoveInLine: 0,
        win: false,
        moves: 0,
        moveScores: 0,
        moveDurations: [],
        movesInLines: [],
        errorMoves: 0,
        loseMoves: 0,
        simpleMoves: 0,
        scoreMoves: 0,
        whiteBalls: 0,
        blackBalls: 0,
        enemyBalls: 0,
        randomBalls: 0,
        currentBalls: 0,
      ),
      _factory(
        user: users[1],
        leftBalls: 0,
        startMoveTime: DateTime.now(),
        currentMoveInLine: 0,
        win: false,
        moves: 0,
        moveScores: 0,
        moveDurations: [],
        movesInLines: [],
        errorMoves: 0,
        loseMoves: 0,
        simpleMoves: 0,
        scoreMoves: 0,
        whiteBalls: 0,
        blackBalls: 0,
        enemyBalls: 0,
        randomBalls: 0,
        currentBalls: 0,
      ),
    ];
  }

  @override
  Future<void> seed(IPlayerRepository repository) async {
    final players = await _generate();
    for (var player in players) {
      await repository.add(player);
    }
  }
}

