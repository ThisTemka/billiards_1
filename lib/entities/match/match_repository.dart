import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/match/i_match.dart';
import 'package:billiards/entities/match/i_match_repository.dart';
import 'package:billiards/entities/match/match_seeder.dart';
import 'package:billiards/objectbox.g.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:billiards/entities/match/match.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';

final matchRepositoryProvider = FutureProvider<IMatchRepository>((ref) async {
  final store = await ref.read(storeServiceProvider.future);
  final repository = store.getRepository<Match>();
  final matchRepository = MatchRepository(repository, ref);
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  if (isClear) {
    await repository.clear();
  }
  if (isDev) {
    await matchRepository.clear();
    final seeder = await ref.read(matchSeederProvider.future);
    await seeder.seed(matchRepository);
  }
  return matchRepository;
});

class MatchRepository implements IMatchRepository {
  final IRepository<Match> _repository;
  final Ref ref;

  MatchRepository(this._repository, this.ref);

  @override
  Future<int> add(IMatch entity) async {
    final id = await _repository.add(entity as Match);
    ref.notifyListeners();
    return Future.value(id);
  }

  @override
  Future<int> clear() async {
    final count = await _repository.clear();
    ref.notifyListeners();
    return Future.value(count);
  }

  @override
  Future<bool> delete(int id) async {
    final result = await _repository.delete(id);
    ref.notifyListeners();
    return Future.value(result);
  }

  @override
  Future<IMatch?> get(int id) async {
    final entity = await _repository.get(id);
    return Future.value(entity);
  }

  @override
  Future<List<IMatch>> getAll() async {
    final entities = await _repository.getAll();
    return Future.value(entities);
  }

  @override
  Future<int> refresh(IMatch entity) async {
    final id = await _repository.refresh(entity as Match);
    ref.notifyListeners();
    return Future.value(id);
  }
}
