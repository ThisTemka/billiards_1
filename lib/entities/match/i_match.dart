import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/services/store/i_entity.dart';

abstract interface class IMatch implements IEntity {
  List<IRound> get rounds;
  List<IUser> get users;
  DateTime get start;
  DateTime? get end;


  IMatch copyWith({
    List<IRound>? rounds,
    List<IUser>? users,
    DateTime? start,
    DateTime? end,
    bool nullEnd,
  });
}