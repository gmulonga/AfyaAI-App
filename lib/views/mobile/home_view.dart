import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afyaai/controllers/home_controller.dart';
import 'package:afyaai/services/localstorage_service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String? storedUserName = await StorageService.getData('userName');
    setState(() {
      userName = storedUserName ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Center(
        child: Text('Mobile Home View'),
      ),
    );
  }
}
