import 'package:billiards/services/router/router_service.dart';
import 'package:billiards/services/translation/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerService = ref.read(routerServiceProvider);
    final translationService = ref.read(translationServiceProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        getPages: routerService.getPages,
        initialRoute: routerService.initialPage,
        unknownRoute: routerService.unknownPage,
        translations: translationService as Translations,
        fallbackLocale: const Locale('en'),
      ),
    );
  }
}
