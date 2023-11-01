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
    Get.offAndToNamed(Routes.EDIT);
  }

  void view_images(){
    Get.offAndToNamed(Routes.SHOWCASE);
  }

  void manage_admin_list(){
    Get.offAndToNamed(Routes.ADMIN);
  }

  List<Widget> buttonsFromAdminStatus(bool admin){
    List<Widget> children = <Widget>[];
    children.add(ElevatedButton(onPressed: () => view_images(), child: Text('View Images')));
    children.add(Container(width: 10,));
    children.add(ElevatedButton(onPressed: () => edit_images(), child: Text('Edit Images')));
    children.add(Container(width: 10,));
    children.add(ElevatedButton(onPressed: () => being_logout(), child: Text('Logout')));
    //first,
    if(admin){
      Widget adminButton = ElevatedButton(onPressed: () => being_logout(), child: Text('Logout'));
      children.add(adminButton);
    }
    return children;
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
                          Text('   Admin:   ' + loginController.admin.toString()),

                          Text(''),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: buttonsFromAdminStatus(loginController.admin),
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


