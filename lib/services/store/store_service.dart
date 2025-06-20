import 'package:billiards/objectbox.g.dart';
import 'package:billiards/services/store/i_entity.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/i_store_service.dart';
import 'package:billiards/services/store/object_box_repository_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeServiceProvider = FutureProvider<IStoreService>((ref) async {
  final store = await openStore();
  return StoreService(store);
});

class StoreService implements IStoreService{
  final Store _store;

  StoreService(this._store);

  @override
  IRepository<T> getRepository<T extends IEntity>() {
    return ObjectBoxRepositoryWrapper<T>(_store.box<T>());
  }

}