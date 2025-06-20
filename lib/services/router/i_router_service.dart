import 'package:get/get.dart';

abstract interface class IRouterService {
  List<GetPage> get getPages;
  String get initialPage;
  GetPage get unknownPage;
}


