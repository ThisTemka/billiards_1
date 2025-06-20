import 'package:billiards/entities/match/i_match_repository.dart';

abstract interface class IMatchSeeder{
  Future<void> seed(IMatchRepository repository);
}