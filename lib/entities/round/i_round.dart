import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/services/store/i_entity.dart';

abstract interface class IRound implements IEntity {
  DateTime get start;
  DateTime? get end;
  List<IPlayer> get players;

  IRound copyWith({
    List<IPlayer>? players,
    DateTime? start,
    DateTime? end,
    bool nullEnd,
  });
}