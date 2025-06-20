import 'package:billiards/entities/player/i_player_repository.dart';
import 'package:billiards/entities/player/player_repository.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/round/i_round_factory.dart';
import 'package:billiards/entities/round/i_round_repository.dart';
import 'package:billiards/entities/round/i_round_seeder.dart';
import 'package:riverpod/riverpod.dart';

final roundSeederProvider = FutureProvider.autoDispose<IRoundSeeder>((ref) async {
    final playerRepository = await ref.read(playerRepositoryProvider.future);
    final factory = ref.read(roundFactoryProvider);
    return RoundSeeder(factory, playerRepository);
});

class RoundSeeder implements IRoundSeeder {
    final IRoundFactory _factory;
    final IPlayerRepository _playerRepository;

    RoundSeeder(this._factory, this._playerRepository);

    Future<List<IRound>> _generate() async {
        final players = await _playerRepository.getAll();
        return [
            _factory(
                players: [
                    players[0],
                    players[1],
                ],
                start: DateTime.now(),
                end: DateTime.now().add(Duration(minutes: 10)),
            ),
        ];
    }

    @override
    Future<void> seed(IRoundRepository repository) async {
        final rounds = await _generate();
        for (var round in rounds) {
            await repository.add(round);
        }
    }
}
