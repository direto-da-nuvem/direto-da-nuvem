import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer' as developer;


class ShowcasePage extends StatefulWidget {
  const ShowcasePage({Key? key}) : super(key: key);


  @override
  State<ShowcasePage> createState(){
    return _ShowcasePageState();}
}

class _ShowcasePageState extends State<ShowcasePage> {
  var currentQueueFile = (Get.arguments)+"_Requests.txt";

  String selectedItem = "ShowcasePage";
  bool isLoading = true;

  final List<Image> imageAssets = <Image>[];
  List<String> RequestedImages = <String>[];

  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  bool instQueue = false;
  Future<void> getImageData() async {
    if(currentQueueFile=="InstallationQueue_Requests.txt"){instQueue = true;
    RequestedImages = ["1.png","2.png","3.png","4.png","5.png"];
    print('Sword Coast');}
    else{
    await getRequestedImages();}
    for(String s in RequestedImages){
      print(s);
      print("1.png");
      //print(s[5]);
      //print("1.png"[5]);
      dynamic i = await storage.ref().child(s).getData();
      print(s);
      Image im = Image.memory(i,fit:BoxFit.cover);
      print(s);
      imageAssets.add(im);
      developer.log("FINISHED LOADING IMAGE $s");}
    finishedLoading();
    return;
  }

  List<String> defaultImages = <String>['cat.jpg','rocket.jpg','lake.jpg'];

  Future<void> getRequestedImages() async{
    dynamic requests = await storage.ref().child(currentQueueFile).getData();

    String sRequests = utf8.decode(requests);
    List<String> files = sRequests.toString().split('\n');

    if(files.length<1){RequestedImages = defaultImages;print('No requests found, selected default images to play.');}
    else{
      RequestedImages = [];
      for(int i = 0; i<files.length;i++){
        print(files[i]);
        print(i);
        if(files[i].removeAllWhitespace !='' && files[i] != Null && files[i] != ' ' && files[i] != ''){
        RequestedImages.add(files[i]);}
    }
      //RequestedImages.forEach((element) {print(element);});
    }
    return;
  }

  void goBack(){
    if(!instQueue){
    Get.offAndToNamed(Routes.DASHBOARD, arguments: currentQueueFile);}
    else{
      Get.offAndToNamed(Routes.LOGIN, arguments: false);
    }
  }

  void finishedLoading(){setState(() {
    isLoading = false;
  });}

  bool gotImages = false;
  dynamic tempImages;
  @override
  Widget build(BuildContext context) {
    print('a');
    if(!gotImages){
    getImageData();
    gotImages = true;
    print(imageAssets.length);
    }

    return Scaffold(
      backgroundColor: Colors.black38,
      body: isLoading ? const Center(child: CircularProgressIndicator()) : GestureDetector(
        onDoubleTap: ()=>goBack(),
        child: CarouselSlider.builder(
          options: CarouselOptions(height: 500, autoPlay: true, autoPlayInterval: Duration(seconds: 5), viewportFraction: 1, autoPlayAnimationDuration: Duration(milliseconds: 350),),
          itemCount: imageAssets.length,
          itemBuilder: (context,index,realIndex){
            return imageAssets[index];
            },
        ),
      ),
    );
  }
}



