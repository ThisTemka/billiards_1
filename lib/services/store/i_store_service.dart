import 'package:billiards/services/store/i_entity.dart';
import 'package:billiards/services/store/i_repository.dart';

abstract interface class IStoreService {
  IRepository<T> getRepository<T extends IEntity>();
}