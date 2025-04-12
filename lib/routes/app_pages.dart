import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:afyaai/views/web/home_view.dart' as web;
import 'package:afyaai/views/mobile/home_view.dart' as mobile;
import 'package:afyaai/views/web/auth/login_view.dart' as webLogin;
import 'package:afyaai/views/mobile/auth/login_screen.dart' as mobileLogin;
import 'package:afyaai/views/mobile/get_started_view.dart' as mobileGetStarted;
import 'package:afyaai/controllers/home_controller.dart';
import 'package:afyaai/controllers/login_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.getStarted,
      page: () => kIsWeb ? webLogin.LoginWebView() : mobileGetStarted.Home(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => kIsWeb ? web.HomeView() : mobile.HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => kIsWeb ? webLogin.LoginWebView() : mobileLogin.LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
  ];
}
