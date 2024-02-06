import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
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

class AnimationData{
  String name;
  Curve curve;
  int durationMilliseconds;
  int getDuration(){return durationMilliseconds;}
  AnimationData({required this.name, required this.curve, required this.durationMilliseconds});
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
    RequestedImages = ["1.png","2.png","3.png","4.png"]; //This probably shouldn´t be hardcoded.
    //TO-DO: Edit above structures
}
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
    queueScreenTime = c.docs[0].data()['screenTime'];
    animEffectByName(c.docs[0].data()['entryEffect']);
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

  void animEffectByName(String effect){ //TO-DO: criar um map pra essas animações e fazer a consulta mais rapido
    print(effect);
    if(effect == "instantaneous"){animationCurve = Curves.linear;  durationMilliseconds = 500;enlargeStrategy = CenterPageEnlargeStrategy.height; return;} //TO-DO: change this for a switch case eventually
    if(effect == "bounce"){animationCurve = Curves.bounceOut;  enlargeStrategy = CenterPageEnlargeStrategy.height; durationMilliseconds = 1600; return;}
    if(effect == "slide"){animationCurve = Curves.easeOutExpo; enlargeCenter = false; durationMilliseconds = 3200; return;}
    if(effect == "grow"){animationCurve = Curves.easeInOutCubicEmphasized;  durationMilliseconds = 2800; enlargeFactor = 0.8; return;}
    if(effect == "fast"){animationCurve = Curves.easeInOutCubicEmphasized; enlargeCenter = false;  durationMilliseconds = 3200; return;}
    if(effect == "elastic"){animationCurve = Curves.elasticInOut;  enlargeStrategy = CenterPageEnlargeStrategy.zoom;durationMilliseconds = 2400; return;}
    if(effect == "slow"){animationCurve = Curves.easeInOutSine;  durationMilliseconds = 1600; return;}
    if(effect == "preview"){animationCurve = Curves.slowMiddle;  durationMilliseconds = 1000;  enlargeFactor = 0.6;enlargeStrategy = CenterPageEnlargeStrategy.zoom; enlargeCenter = true;return;}//linearToEaseOut
    if(effect == "vertical"){animationCurve = Curves.linearToEaseOut; enlargeStrategy = CenterPageEnlargeStrategy.zoom; enlargeCenter = true; enlargeFactor = 0.5; durationMilliseconds = 1100;scrollDirection = Axis.vertical;}//linearToEaseOut
    if(effect == "inverted vertical"){animationCurve = Curves.linearToEaseOut; enlargeStrategy = CenterPageEnlargeStrategy.zoom;reverse = true; enlargeCenter = true; enlargeFactor = 0.5; durationMilliseconds = 1100;scrollDirection = Axis.vertical;}//linearToEaseOut
    if(effect == "backwards"){animationCurve = Curves.linearToEaseOut;  durationMilliseconds = 900; reverse = true; return;}//linearToEaseOut
    if(effect == "default"){animationCurve = Curves.linearToEaseOut;  durationMilliseconds = 900; return;}//linearToEaseOut
    animationCurve = Curves.linear;  durationMilliseconds = 800; //default
  }

  Curve animationCurve = Curves.linear;
  int durationMilliseconds = 100;
  CenterPageEnlargeStrategy enlargeStrategy = CenterPageEnlargeStrategy.scale;
  bool enlargeCenter = true;
  bool reverse = false;
  double enlargeFactor = 0.4;
  Axis scrollDirection = Axis.horizontal;

  dynamic tempImages;
  int queueScreenTime = 8;
  int getTimeForImage(int index){return queueScreenTime;}




  @override

  Widget build(BuildContext context) {
   print('building');
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
          options: CarouselOptions(
            height: 2500,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: getTimeForImage(gindex)),
            enlargeCenterPage: enlargeCenter,
            reverse: reverse,
            enlargeStrategy: enlargeStrategy,
            enlargeFactor: enlargeFactor,
            viewportFraction: 1,
            autoPlayCurve:  animationCurve,
            scrollDirection: scrollDirection,
            autoPlayAnimationDuration: Duration(milliseconds: durationMilliseconds),),
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



