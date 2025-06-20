import 'package:billiards/entities/user/i_user_repository.dart';

abstract interface class IUserSeeder {
  Future<void> seed(IUserRepository repository);
}


