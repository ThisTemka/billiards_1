import 'package:billiards/services/store/i_entity.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:objectbox/objectbox.dart';

class ObjectBoxRepositoryWrapper<T extends IEntity> implements IRepository<T>{
  final Box<T> _box;

  ObjectBoxRepositoryWrapper(this._box);

  @override
  Future<int> add(T entity) async {
    final id = await _box.putAsync(entity);
    entity.id = id;
    return id;
  }

  @override
  Future<int> clear() async {
    return _box.removeAllAsync();
  }

  @override
  Future<bool> delete(int id) async {
    return _box.removeAsync(id);
  }

  @override
  Future<T?> get(int id) async {
    return _box.get(id);
  }

  @override
  Future<List<T>> getAll() async {
    return await _box.getAllAsync();
  }

  @override
  Future<int> refresh(T entity) async {
    final id = await _box.putAsync(entity, mode: PutMode.update);
    return id;
  }

}