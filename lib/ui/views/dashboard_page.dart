import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/dashboard_controller.dart';
import 'package:sample/controllers/login_controller.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedItem = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: Get.put(DashboardController()),
        builder: (homeController) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard'),
              centerTitle: true,
            ),
            drawer: Drawer(
              width: 200,
              backgroundColor: const Color.fromARGB(201, 209, 242, 255),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(243, 245, 252, 255),
                    ),
                    child: Image(image: AssetImage("assets/logo.png")),
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.apps),
                        Text(" Dashboard"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Dashboard clicked");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.add),
                        Text(" Provide sample"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Provide sample clicked");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.search),
                        Text(" Search"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Search clicked");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.messenger_outline_sharp),
                        Text(" Messages"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Messages clicked");
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    color: Colors.white,
                    child: const SizedBox(
                      height: 5,
                    ),
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.settings),
                        Text(" Settings"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Settings clicked");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.info),
                        Text(" Smaple.io"),
                      ],
                    ),
                    onTap: () {
                      debugPrint("Sample.io clicked");
                      Navigator.pop(context);
                    },
                  ),
                  GetBuilder<LoginController>(
                    init: Get.put(LoginController()),
                    builder: (loginController) {
                    return ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                              width: 130,
                              child: Text(loginController.auth.currentUser!.displayName!.toString()),
                          ),
                          const Icon(Icons.exit_to_app),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Future.delayed(const Duration(seconds: 1), () {
                          loginController.signInWithGoogle();
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text('My Samples'),
                    children: <Widget>[
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" My samples test item 0"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("My samples test item 0 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" My samples test item 1"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("My samples test item 1 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" My samples test item 2"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("My samples test item 2 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" My samples test item 3"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("My samples test item 3 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" My samples test item 4"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("My samples test item 4 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Favorite Samples'),
                    children: <Widget>[
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite sample test item 0"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite sample test item 0 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite sample test item 1"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite sample test item 1 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite sample test item 2"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite sample test item 2 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite sample test item 3"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite sample test item 3 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite sample test item 4"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite sample test item 4 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Favorite Provider'),
                    children: <Widget>[
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite provider test item 0"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite provider test item 0 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite provider test item 1"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite provider test item 1 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite provider test item 2"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite provider test item 2 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite provider test item 3"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite provider test item 3 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.science),
                            Text(" Favorite provider test item 4"),
                          ],
                        ),
                        onTap: () {
                          debugPrint("Favorite provider test item 4 clicked");
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
