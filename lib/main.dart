import 'package:billiards/core/application.dart';
import 'package:billiards/core/application_bootstrap.dart';
import 'package:billiards/core/core_bootstrap.dart';
import 'package:billiards/services/notification/notification_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация сервиса уведомлений
  await NotificationService().initialize();

  final container = ProviderContainer();

  await container.read(coreBootstrapProvider.future);
  await container.read(applicationBootstrapProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container, 
      child: Application()
    )
  );
}
