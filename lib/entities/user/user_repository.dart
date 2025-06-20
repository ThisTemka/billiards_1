import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/user/i_user.dart';
import 'package:billiards/entities/user/i_user_repository.dart';
import 'package:billiards/entities/user/user_seeder.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:billiards/entities/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = FutureProvider<IUserRepository>((ref) async {
  final store = await ref.read(storeServiceProvider.future);
  final repository = store.getRepository<User>();
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  final userRepository = UserRepository(repository, ref);
  if (isClear) {
    await repository.clear();
  }
  if (isDev) {
    await repository.clear();
    final seeder = await ref.read(userSeederProvider.future);
    await seeder.seed(userRepository);
  }
  return userRepository;
});

class UserRepository implements IUserRepository {
  final Ref ref;
  final IRepository<User> _repository;

  UserRepository(this._repository, this.ref);

  @override
  Future<int> add(IUser entity) async {
    final id = await _repository.add(entity as User);
    ref.notifyListeners();
    return Future.value(id);
  }

  @override
  Future<List<IUser>> getAll() async {
    final users = await _repository.getAll();
    return Future.value(users);
  }

  @override
  Future<IUser?> get(int id) async {
    final user = await _repository.get(id);
    return Future.value(user);
  }

  @override
  Future<int> refresh(IUser entity) async {
    final count = await _repository.refresh(entity as User);
    ref.notifyListeners();
    return Future.value(count);
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
}
