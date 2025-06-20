import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/i_user_factory.dart';
import 'package:billiards/entities/user/i_user_repository.dart';
import 'package:billiards/entities/user/i_user_seeder.dart';
import 'package:riverpod/riverpod.dart';

final userSeederProvider = FutureProvider.autoDispose<IUserSeeder>((ref) async {
  final factory = ref.read(userFactoryProvider);
  return UserSeeder(factory);
});

class UserSeeder implements IUserSeeder {
    final IUserFactory _factory;

    UserSeeder(this._factory);

    Future<List<IUser>> _generate() async {
        return [
            _factory(
                name: 'Player 1', 
                whiteBalls: 0,
                blackBalls: 0,
                currentBalls: 0,
                randomBalls: 0,
                enemyBalls: 0,
                errorMoves: 0,
                loseMoves: 0,
                simpleMoves: 0,
                scoreMoves: 0,
                rounds: 0,
                roundWins: 0,
                roundLoses: 0,
                moveScores: 0,
                moves: 0,
                movesInLines: [],
                moveDurations: [],
            ),
            _factory(
                name: 'Player 2', 
                whiteBalls: 0,
                blackBalls: 0,
                currentBalls: 0,
                randomBalls: 0,
                enemyBalls: 0,
                errorMoves: 0,
                loseMoves: 0,
                simpleMoves: 0,
                scoreMoves: 0,
                rounds: 0,
                roundWins: 0,
                roundLoses: 0,
                moveScores: 0,
                moves: 0,
                movesInLines: [],
                moveDurations: [],
            ),
        ];
    }

    @override
    Future<void> seed(IUserRepository repository) async {
        final users = await _generate();
        for (var user in users) {
            await repository.add(user);
        }
    }
}


