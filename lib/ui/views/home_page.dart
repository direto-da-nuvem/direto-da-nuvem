import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/home_controller.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Sample'),
              // centerTitle: true,
              actions: [],
            ),
            body: Text("Sample Test Page",
              style: TextStyle(color: Colors.white)
            )
        );
      }
    );
  }
}
