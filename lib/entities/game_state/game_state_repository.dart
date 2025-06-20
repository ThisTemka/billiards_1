import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/game_state/game_state.dart';
import 'package:billiards/entities/game_state/game_state_seeder.dart';
import 'package:billiards/entities/game_state/i_game_state_repository.dart';
import 'package:billiards/entities/game_state/i_game_state.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:riverpod/riverpod.dart';

final gameStateRepositoryProvider =
    FutureProvider<IGameStateRepository>((ref) async {
  final store = await ref.watch(storeServiceProvider.future);
  final repository = store.getRepository<GameState>();
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  final gameStateRepository = GameStateRepository(repository, ref);
  if (isClear) {
    await repository.clear();
  }
  await gameStateRepository.init();
  if (isDev) {
    final gameStateSeeder = ref.read(gameStateSeederProvider);
    await gameStateSeeder.seed(gameStateRepository);
  }
  return gameStateRepository;
});

class GameStateRepository implements IGameStateRepository {
  final IRepository<IGameState> _repository;
  final Ref ref;

  GameStateRepository(this._repository, this.ref);

  Future<void> init() async {
    final gameState = await _repository.getAll();
    if (gameState.isEmpty) {
      await _createEntity();
    }
  }

  Future<IGameState> _createEntity() async {
    final entity = GameState.create(
        currentMatch: null, currentRound: null, currentPlayer: null);
    await _repository.add(entity);
    return entity;
  }

  @override
  Future<IGameState> getGameState() async {
    final gameState = await _repository.getAll();
    return gameState.first;
  }

  @override
  Future<int> setGameState(IGameState gameState) async {
    final id = await _repository.refresh(gameState as GameState);
    ref.notifyListeners();
    return id;
  }

  @override
  Future<void> resetGameState() async {
    await _repository.clear();
    await _createEntity();
    ref.notifyListeners();
  }
}
