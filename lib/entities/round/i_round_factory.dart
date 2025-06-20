import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:riverpod/riverpod.dart';

typedef IRoundFactory = IRound Function({
    required List<IPlayer> players,
    required DateTime start,
    required DateTime? end,
});

final roundFactoryProvider = Provider<IRoundFactory>((ref) {
    return ({
        required List<IPlayer> players,
        required DateTime start,
        required DateTime? end,
    }) {
        return Round.create(
            players: players,
            start: start,
            end: end,
        );
    };
});