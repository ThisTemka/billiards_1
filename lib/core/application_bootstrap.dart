import 'package:billiards/services/router/router_service.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:billiards/services/translation/translation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationBootstrapProvider = FutureProvider((ref) async {
  ref.read(routerServiceProvider);
  await ref.watch(themeServiceFutureProvider.future);
  await ref.watch(localeProvider.future);
  ref.read(translationServiceProvider);
});
