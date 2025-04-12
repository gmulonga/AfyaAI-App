import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:afyaai/views/web/home_view.dart' as web;
import 'package:afyaai/views/mobile/home_view.dart' as mobile;
import 'package:afyaai/controllers/home_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () {
        if (kIsWeb) {
          return web.HomeView();
        } else {
          return mobile.HomeView();
        }
      },
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
  ];
}
