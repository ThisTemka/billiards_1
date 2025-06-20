import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/round/i_round.dart';
import 'package:billiards/entities/round/i_round_repository.dart';
import 'package:billiards/entities/round/round_seeder.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:billiards/entities/round/round.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roundRepositoryProvider = FutureProvider<IRoundRepository>((ref) async {
  final store = await ref.read(storeServiceProvider.future);
  final repository = store.getRepository<Round>();
  final roundRepository = RoundRepository(repository, ref);
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  if (isClear) {
    await repository.clear();
  }
  if (isDev) {
    await roundRepository.clear();
    final seeder = await ref.read(roundSeederProvider.future);
    await seeder.seed(roundRepository);
  }
  return roundRepository;
});

class RoundRepository implements IRoundRepository {
  final IRepository<Round> _repository;
  final Ref ref;

  RoundRepository(this._repository, this.ref);

  @override
  Future<int> add(IRound entity) async {
    final id = await _repository.add(entity as Round);
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
  Future<IRound?> get(int id) async {
    final round = await _repository.get(id);
    ref.notifyListeners();
    return Future.value(round);
  }

  @override
  Future<List<IRound>> getAll() async {
    final rounds = await _repository.getAll();
    ref.notifyListeners();
    return Future.value(rounds);
  }

  @override
  Future<int> refresh(IRound entity) async {
    final count = await _repository.refresh(entity as Round);
    ref.notifyListeners();
    return Future.value(count);
  }
}
