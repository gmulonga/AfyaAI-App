import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfyaAI',
      initialRoute: kIsWeb ? AppRoutes.login : AppRoutes.getStarted,
      getPages: AppPages.routes,
    );
  }
}