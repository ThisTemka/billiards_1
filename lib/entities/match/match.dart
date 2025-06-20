import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Match implements IMatch {
  
  @override
  late int id;

  @override
  @Transient()
  List<IUser> get users => rusers.toList();
  
  final ToMany<User> rusers;

  @override
  @Transient()
  List<IRound> get rounds => rrounds.toList();
  
  final ToMany<Round> rrounds;

  @override
  final DateTime start;
  @override
  final DateTime? end;

  Match({ 
    required this.id,
    required this.rrounds,
    required this.rusers,
    required this.start,
    required this.end,
  });

  Match.create({ 
    this.id = 0,
    required List<IRound> rounds,
    required List<IUser> users,
    required this.start,
    this.end,
  }) : 
    rrounds = ToMany(items: rounds.map((round) => round as Round).toList()),
    rusers = ToMany(items: users.map((user) => user as User).toList());

  @override
  IMatch copyWith({
    List<IRound>? rounds,
    List<IUser>? users,
    DateTime? start,
    DateTime? end,
    bool nullEnd = false,
  }) {
    return Match.create(
      id: id,
      rounds: rounds ?? this.rounds,
      users: users ?? this.users,
      start: start ?? this.start,
      end: nullEnd ? null : end ?? this.end,
    );
  }
}