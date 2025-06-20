import 'package:billiards/pages/match_history/match_history_page.dart';
import 'package:billiards/pages/round_history/round_history_page.dart';
import 'package:billiards/services/router/i_router_service.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';
import 'package:billiards/pages/home/home_page.dart';
import 'package:billiards/pages/game/game_page.dart';
import 'package:billiards/pages/round_statistics/round_statistics_page.dart';
import 'package:billiards/pages/history/history_page.dart';
import 'package:billiards/pages/game_statistics/game_statistics_page.dart';
import 'package:billiards/pages/settings/settings_page.dart';
import 'package:billiards/pages/users/users_page.dart';
import 'package:billiards/pages/user/user_page.dart';
import 'package:billiards/pages/unknown/unknown_page.dart';

final routerServiceProvider = Provider<IRouterService>((ref) {
  return RouterService();
});

class RouterService implements IRouterService {
  @override
  List<GetPage> get getPages => [
    GetPage(name: '/', page: () => const HomePage()),
    GetPage(name: '/game', page: () => const GamePage()),
    GetPage(name: '/roundStatistics', page: () => const RoundStatisticsPage()),
    GetPage(name: '/history', page: () => const HistoryPage()),
    GetPage(name: '/gameStatistics', page: () => const GameStatisticsPage()),
    GetPage(name: '/settings', page: () => const SettingsPage()),
    GetPage(name: '/users', page: () => const UsersPage()),
    GetPage(name: '/user', page: () => const UserPage()),
    GetPage(name: '/unknown', page: () => const UnknownPage()),
    GetPage(name: '/match_history', page: () =>  MatchHistoryPage()),
    GetPage(name: '/round_history', page: () =>  RoundHistoryPage()),
  ];

  @override
  String get initialPage => '/';

  @override
  GetPage get unknownPage => GetPage(name: '/unknown', page: () => const UnknownPage());
}
