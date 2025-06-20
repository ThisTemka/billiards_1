import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/match/i_match_factory.dart';
import 'package:billiards/entities/match/i_match_repository.dart';
import 'package:billiards/entities/match/i_match_seeder.dart';
import 'package:billiards/entities/round/i_round_repository.dart';
import 'package:billiards/entities/round/round_repository.dart';
import 'package:billiards/entities/user/i_user_repository.dart';
import 'package:billiards/entities/user/user_repository.dart';
import 'package:riverpod/riverpod.dart';

final matchSeederProvider = FutureProvider.autoDispose<IMatchSeeder>((ref) async {
  final roundRepository = await ref.read(roundRepositoryProvider.future);
  final userRepository = await ref.read(userRepositoryProvider.future);
  final factory = ref.read(matchFactoryProvider);
  return MatchSeeder(factory, roundRepository, userRepository);
});

class MatchSeeder implements IMatchSeeder{
  final IMatchFactory _factory;
  final IRoundRepository _roundRepository;
  final IUserRepository _userRepository;

  MatchSeeder(this._factory, this._roundRepository, this._userRepository);

  Future<List<IMatch>> _generate() async {
    final rounds = await _roundRepository.getAll();
    final users = await _userRepository.getAll();
    return [
      _factory(
        rounds: [
          rounds[0],
        ],
        users: [
          users[0],
          users[1],
        ],
        start: DateTime.now(),
        end: DateTime.now().add(Duration(minutes: 10)),
      )
    ];
  }

  @override
  Future<void> seed(IMatchRepository repository) async {
    final matches = await _generate();
    for (var match in matches) {
      await repository.add(match);
    }
  }
}