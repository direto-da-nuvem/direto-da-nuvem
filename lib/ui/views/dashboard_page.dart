import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/dashboard_controller.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:sample/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedItem = "Dashboard";

  final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];


  void being_logout(){
    try{
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    LoginController().backToLogin();
    Get.offAndToNamed(Routes.LOGIN);
    }catch(error){}
    Get.offAndToNamed(Routes.LOGIN);
  }

  void edit_images(){

  }

  void view_images(){
    Get.offAndToNamed(Routes.SHOWCASE);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: Get.put(DashboardController()),
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(
            title:
            Text("DiretoDaUff"),
            centerTitle: false,
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<LoginController>(
                    init: Get.put(LoginController()),
                    builder: (loginController) {
                      return Column(
                        children: [
                          Text(''),
                          Text('   Current User:   ' + loginController.auth.currentUser!.displayName!),
                           Text('   Current Email:   ' + loginController.auth.currentUser!.email!),
                          Text(''),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                ElevatedButton(onPressed: () => view_images(), child: Text('View Images')),
                                Container(width: 10,),
                                ElevatedButton(onPressed: () => edit_images(), child: Text('Edit Images')),
                                Container(width: 10,),
                                ElevatedButton(onPressed: () => being_logout(), child: Text('Logout')),

                              ],
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.start,
                      );
                    }
                )

                //da code goes here

              ],
            ),
          );

      }
    );
  }
}


