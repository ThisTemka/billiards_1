import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/match/match.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:riverpod/riverpod.dart';

typedef IMatchFactory = IMatch Function({
  required List<IRound> rounds,
  required List<IUser> users,
  required DateTime start,
  required DateTime? end,
});

final matchFactoryProvider = Provider<IMatchFactory>((ref) {
  return (
    {
      required List<IRound> rounds,
      required List<IUser> users,
      required DateTime start,
      required DateTime? end,
    }
  ) {
    return Match.create(
      users: users,
      rounds: rounds,
      start: start,
      end: end,
    );
  };
});