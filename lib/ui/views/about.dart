import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/app_pages.dart';



class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  Future<void> goBack() async{
    Get.offAndToNamed(Routes.DASHBOARD,arguments: Get.arguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text("Sobre o Direto Da UFF"), centerTitle: false,leading: IconButton(onPressed: (){goBack();}, icon: Icon(Icons.arrow_back)),),
      body: Text("Seção a ser desenvolvida"),
    );
  }
}

