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
  var currentQueueFile = (Get.arguments[0])+"_Requests.txt";
  bool signedIn = Get.arguments[1];

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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getRequestedImages() async{
    String qname = Get.arguments[0];
    var c = await firestore.collection('queue').where('name',isEqualTo: qname).get();
    var newQueueDocRef = c.docs[0].reference;
    var c2 = await newQueueDocRef.collection('images').get();
    RequestedImages = [];
    for(int i =0; i<c2.docs.length;i++){
      print(c2.docs[i].data()['imagePath']);
      if(c2.docs[i].data()['present']){
      RequestedImages.add(c2.docs[i].data()['imagePath']);}
    }

    if(RequestedImages.length<1){RequestedImages = defaultImages;print('No requests found, selected default images to play.');}
      //RequestedImages.forEach((element) {print(element);});
    return;
  }

  void goBack(){
    if(!instQueue){
      if(!signedIn){Get.offAndToNamed(Routes.LOGIN, arguments: true);}
      else{Get.offAndToNamed(Routes.DASHBOARD, arguments: currentQueueFile);}
    }
    else{Get.offAndToNamed(Routes.LOGIN, arguments: false);}
  }

  void finishedLoading(){setState(() {
    isLoading = false;
  });}

  bool gotImages = false;
  int gindex = 0;
  dynamic tempImages;
  int getTimeForImage(int index){return 30*index + 3;}
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
          options: CarouselOptions(height: 2500, autoPlay: true, autoPlayInterval: Duration(seconds: getTimeForImage(gindex)), viewportFraction: 1, autoPlayAnimationDuration: Duration(milliseconds: 350),),
          itemCount: imageAssets.length,
          itemBuilder: (context,index,realIndex){
            gindex = index;
            return imageAssets[index];
            },
          //carouselController: CarouselController(),
        ),
      ),
    );
  }
}



