import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String selectedQueue = "final";
  bool gotQueue = false;

  void getDeviceQueue() async{
    dynamic requests = await storage.ref().child("queue_devices.txt").getData();
    selectedQueue = queueDeviceFromString("MeuDispositivo",utf8.decode(requests));
    gotQueue = true;
    setState(() {});
  }

  String queueDeviceFromString(deviceName, savedData){
   return 'final';
  }

  final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];

  bool admin = false;
  bool isLoading = true;
  final storage = FirebaseStorage.instance;
  String deviceId = 'MeuDispositivo';
  final deviceInfoPlugin = DeviceInfoPlugin();
  dynamic deviceInfo;


  void checkIfAdmin(String userEmail) async{
    //loadDeviceInfo();
    isLoading = true;
    print('Elements');

    dynamic admins = await storage.ref().child("admin_emails.txt").getData();

    //deviceId = await D.getDeviceId().toString();
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
      Get.offAndToNamed(Routes.LOGIN, arguments: true);
    }catch(error){}
    Get.offAndToNamed(Routes.LOGIN, arguments: true);
  }

  void re(){
    setState(() {

    });
  }

  Future<String> getFirstQueueMappedToDevice(String deviceSerial) async{
    //dynamic requests = await storage.ref().child("queue_data.txt").getData();;//queuesFromString(utf8.decode(requests));
    String deviceName = await DeviceNameFromSerial(deviceSerial);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var c = await firestore.collection('queue').get();
    for(int i =0; i<c.docs.length;i++){

      if(c.docs[i].data()['device'] == deviceName){
        return c.docs[i].data()['name'].toString().removeAllWhitespace;
      }
    }
    return "";
  }

  Future<String> DeviceNameFromSerial(String deviceSerial) async{
    //dynamic requests = await storage.ref().child("queue_data.txt").getData();;//queuesFromString(utf8.decode(requests));
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var c = await firestore.collection('device').get();
    for(int i =0; i<c.docs.length;i++){
      if(c.docs[i].data()['serial'] == deviceSerial){
        return c.docs[i].data()['name'].toString().removeAllWhitespace;
      }
    }
    return "";
  }

  void edit_images(){

    Get.offAndToNamed(Routes.EDIT,arguments: [selectedQueue,true]);
  }
  void edit_queues(){
    Get.offAndToNamed(Routes.QUEUE);
  }
  void view_images(){
    Get.offAndToNamed(Routes.SHOWCASE,arguments: [selectedQueue,true]);
  }
  void manage_admin_list(){
    Get.offAndToNamed(Routes.ADMIN);
  }

  void acessNotifications(){
    Get.offAndToNamed(Routes.NOTIFICATIONS, arguments: [selectedQueue,true]);
  }

  List<Widget> buttonsFromAdminStatus(bool admin){
    List<Widget> children = <Widget>[];
    children.add(ElevatedButton(onPressed: () => view_images(), child: Text('View Images')));
    if(admin){
      Widget queueButton = ElevatedButton(onPressed: () => edit_queues(), child: Text('Manage Queues'));
      children.add(Container(width: 10,));
      children.add(queueButton);

      Widget editB = ElevatedButton(onPressed: () => edit_images(), child: Text('Edit Images'));
      children.add(Container(width: 10,));
      children.add(editB);

      Widget adminButton = ElevatedButton(onPressed: () => manage_admin_list(), child: Text('Manage Admins'));
      children.add(Container(width: 10,));
      children.add(adminButton);


    }
    children.add(Container(width: 10,));
    children.add(ElevatedButton(onPressed: () => being_logout(), child: Text('Logout')));
    return children;
  }

  bool gotAdminStatus = false;
  bool gotAuthData = false;
  var currentAuth;

  String adminSuffix(bool admin){
    if(!admin){return '';}
    return '  (Admin)';
  }
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
                        Text('Current User:   ' + currentAuth.currentUser!.displayName!),
                        Text('Current Email:   ' + currentAuth.currentUser!.email! + adminSuffix(admin)),
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


  bool created = false;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();


  @override
  Widget build(BuildContext context) {

    if(!gotAuthData) {
      return loadUserContext();
    }
    if(!gotQueue){
      getDeviceQueue();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:
          Text("DiretoDaUff"),
          centerTitle: false,
        ),
        body: (!isLoading)?
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){acessNotifications();}, icon: Icon(Icons.notifications))
                ],
              ),
              Column(
                children: [
                  Text('Current User:   ' + currentAuth.currentUser!.displayName!),
                  Text('Current Email:   ' + currentAuth.currentUser!.email! + adminSuffix(admin)),
                  Text('Device: ' + deviceId + ' -- Selected Queue: ' + selectedQueue),
                  Text(''),
                  Text(''),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: buttonsFromAdminStatus(admin),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        ) : CircularProgressIndicator()
    );
  }
}


