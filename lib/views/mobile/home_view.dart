import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afyaai/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text(controller.title.value)),
      body: Center(child: Text('Mobile Home View')),
    );
  }
}
