import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/player/i_player.dart';
import 'package:billiards/entities/player/i_player_repository.dart';
import 'package:billiards/entities/player/player_seeder.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:billiards/entities/player/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerRepositoryProvider = FutureProvider<IPlayerRepository>((ref) async {
  final store = await ref.read(storeServiceProvider.future);
  final repository = store.getRepository<Player>();
  final playerRepository = PlayerRepository(repository, ref);
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  if (isClear) {
    await repository.clear();
  }
  if (isDev) {
    await playerRepository.clear();
    final seeder = await ref.read(playerSeederProvider.future);
    await seeder.seed(playerRepository);
  }
  return playerRepository;
});

class PlayerRepository implements IPlayerRepository {
  final IRepository<Player> _repository;
  final Ref ref;

  PlayerRepository(this._repository, this.ref);

  @override
  Future<int> add(IPlayer entity) async {
    final id = await _repository.add(entity as Player);
    ref.notifyListeners();
    return id;
  }

  @override
  Future<int> clear() async {
    final count = await _repository.clear();
    ref.notifyListeners();
    return count;
  }

  @override
  Future<bool> delete(int id) async {
    final result = await _repository.delete(id);
    ref.notifyListeners();
    return result;
  }

  @override
  Future<IPlayer?> get(int id) async {
    final entity = await _repository.get(id);
    return entity;
  }

  @override
  Future<List<IPlayer>> getAll() async {
    final entities = await _repository.getAll();
    return entities;
  }

  @override
  Future<int> refresh(IPlayer entity) async {
    final id = await _repository.refresh(entity as Player);
    ref.notifyListeners();
    return id;
  }
}
