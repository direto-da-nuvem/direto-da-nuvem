import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/home_controller.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedItem = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
        return Scaffold(
            appBar: AppBar(
              // title: const Text('Sample For Science'),
              centerTitle: true,
            ),
            drawer: Column(
              children: [
                Container(
                  height: 600,
                  child: Drawer(
                    width: 170,
                    backgroundColor: Color.fromARGB(201,209,242,255),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(201,209,242,255),
                          ),
                          child: Text('Drawer Header'),
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
                        ListTile(
                          title: const Row(
                            children: [
                              // TODO: evitar que quebre aundo o nome for muito grande
                              Text("Marcos Fernando", softWrap: true),
                              Icon(Icons.exit_to_app),
                            ],
                          ),
                          onTap: () {
                            debugPrint("Exit clicked");
                             Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: ExpansionTile(
                  title: Text('ExpansionTile 1'),
                  subtitle: Text('Trailing expansion arrow icon'),
                  children: <Widget>[
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(Icons.add),
                          Text(" Provide sample"),
                        ],
                      ),
                      onTap: () {
                        debugPrint("Provide sample clicked");
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          // TODO: evitar que quebre aundo o nome for muito grande
                          Text("Marcos Fernando", softWrap: true),
                          Icon(Icons.exit_to_app),
                        ],
                      ),
                      onTap: () {
                        debugPrint("Exit clicked");
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          // TODO: evitar que quebre aundo o nome for muito grande
                          Text("Marcos Fernando", softWrap: true),
                          Icon(Icons.exit_to_app),
                        ],
                      ),
                      onTap: () {
                        debugPrint("Exit clicked");
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
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
                        // Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          // TODO: evitar que quebre aundo o nome for muito grande
                          Text("Marcos Fernando", softWrap: true),
                          Icon(Icons.exit_to_app),
                        ],
                      ),
                      onTap: () {
                        debugPrint("Exit clicked");
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
            ),

        );
      }
    );
  }
}
