import 'package:billiards/entities/round/i_round_repository.dart';

abstract interface class IRoundSeeder{
    Future<void> seed(IRoundRepository repository);
}
