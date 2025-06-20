import 'package:billiards/entities/match/match_repository.dart';
import 'package:billiards/entities/player/player_repository.dart';
import 'package:billiards/entities/round/round_repository.dart';
import 'package:billiards/entities/user/user_repository.dart';
import 'package:billiards/services/notification/notification_service.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreBootstrapProvider = FutureProvider((ref) async {
  await ref.read(storeServiceProvider.future);
  await ref.read(notificationServiceProvider.future);

  await ref.read(userRepositoryProvider.future);
  await ref.read(playerRepositoryProvider.future);
  await ref.read(roundRepositoryProvider.future);
  await ref.read(matchRepositoryProvider.future);
});