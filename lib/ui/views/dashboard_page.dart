import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
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

  bool admin = false;
  bool isLoading = true;
  final storage = FirebaseStorage.instance;

  void checkIfAdmin(String userEmail) async{
    isLoading = true;
    print('Elements');

    dynamic admins = await storage.ref().child("admin_emails.txt").getData();

    print('Elements');

    String sAdmins = utf8.decode(admins);
    List<String> files = sAdmins.toString().split('\n');

    List<String> systemAdmins = [];
    for(int i = 0; i<files.length;i++)
    {
      if(files[i].removeAllWhitespace !='' && files[i] != Null && files[i] != ' ' && files[i] != '')
      {
        systemAdmins.add(files[i]);
      }
    }
    print('Elements');
    systemAdmins.forEach((element) {print(element);print(element==userEmail);});
    print(userEmail);
    admin = false;
    try{
      admin = systemAdmins.contains(userEmail);}catch(_){}
    print(admin);
      gotAdminStatus = true;
      isLoading = false;
    re();
  }

  void being_logout(){
    try{
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    LoginController().backToLogin();
    Get.offAndToNamed(Routes.LOGIN);
    }catch(error){}
    Get.offAndToNamed(Routes.LOGIN);
  }

  void re(){
    print('rrrrrrrrrrr');
    setState(() {

    });
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
      Widget adminButton = ElevatedButton(onPressed: () => manage_admin_list(), child: Text('Admin Screen'));
      children.add(Container(width: 10,));
      children.add(adminButton);
    }
    return children;
  }

  bool gotAdminStatus = false;
  bool gotAuthData = false;
  var currentAuth;

  Widget loadUserContext() {
    return GetBuilder<DashboardController>(
        init: Get.put(DashboardController()),
        builder: (homeController) {
          return GetBuilder<LoginController>(
              init: Get.put(LoginController()),
              builder: (loginController) {
                currentAuth = loginController.auth;
                if(currentAuth!=null){
                  gotAuthData = true;}
                checkIfAdmin(currentAuth.currentUser!.email!);
                return Scaffold(
                  appBar: AppBar(title: Text('DiretoDaUff')),
                  body: (!isLoading)? Column(
                    children: [
                      Text(''),
                      Text('   Current User:   ' + currentAuth.currentUser!.displayName!),
                      Text('   Current Email:   ' + currentAuth.currentUser!.email!),
                      Text('   Admin:   ' + admin.toString()),
                      Text(''),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: buttonsFromAdminStatus(currentAuth),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ) : Center(child: CircularProgressIndicator())
                );
              }
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    if(!gotAuthData) {
      return loadUserContext();
    }

    return Scaffold(
            appBar: AppBar(
              title:
              Text("DiretoDaUff"),
              centerTitle: false,
            ),
            body: (!isLoading)? Column(
                        children: [
                          Text(''),
                          Text('   Current User:   ' + currentAuth.currentUser!.displayName!),
                          Text('   Current Email:   ' + currentAuth.currentUser!.email!),
                          Text('   Admin:   ' + admin.toString()),
                          Text(''),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: buttonsFromAdminStatus(admin),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ) : CircularProgressIndicator()
            );
  }
}


