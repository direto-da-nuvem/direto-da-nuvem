import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../routes/app_pages.dart';

class StartPage extends StatefulWidget {

  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  bool deviceConfigured = true;
  bool checkingDevice = false;

  void checkIfDeviceConfigured() async{
    deviceConfigured = false;
    if(!deviceConfigured){
      Future.delayed(Duration.zero, () async {
        print('abdsdab');
        Get.offAndToNamed(Routes.SHOWCASE, arguments: "InstallationQueue");
      });}
    else{
      Future.delayed(Duration.zero, () async {
        Get.offAndToNamed(Routes.LOGIN, arguments: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!checkingDevice){
      checkingDevice = true;
      checkIfDeviceConfigured();
    }
    return Scaffold();
  }
}

