import 'package:billiards/services/store/i_entity.dart';

abstract interface class IRepository<T extends IEntity> {
  Future<T?> get(int id);
  Future<List<T>> getAll();
  Future<int> add(T entity);
  Future<int> refresh(T entity);
  Future<bool> delete(int id);
  Future<int> clear();
}