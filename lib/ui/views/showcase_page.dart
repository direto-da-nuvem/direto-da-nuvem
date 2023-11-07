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
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  String selectedItem = "ShowcasePage";
  bool isLoading = true;

  final List<Image> imageAssets = <Image>[];
  List<String> RequestedImages = <String>[];

  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;


  Future<void> getImageData() async {
    await getRequestedImages();
    for(String s in RequestedImages){
      dynamic i = await storage.ref().child(s).getData();
      Image im = Image.memory(i,fit:BoxFit.cover);
      imageAssets.add(im);
      developer.log("FINISHED LOADING IMAGE $s");}
    finishedLoading();
    return;
  }

  List<String> defaultImages = <String>['cat.jpg','rocket.jpg','lake.jpg'];

  Future<void> getRequestedImages() async{
                                                //Queue1_Requests.txt
    dynamic requests = await storage.ref().child("Queue1_Requests.txt").getData();

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
    //var filePath = p.join(Directory.current.path, 'assets', 'requests_cache.txt');
    //p.join(Directory.current.path, 'assets', 'sample.txt');
    //File file = File(filePath);
    //var fileContent = file.readAsStringSync();
    //print(fileContent);
    //for(int i =0;i<100;i++){print(i);}

    return;
  }
  //final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];
  void goBack(){
    Get.offAndToNamed(Routes.DASHBOARD);
  }

  void finishedLoading(){setState(() {
    isLoading = false;
  });}

  bool gotImages = false;
  dynamic tempImages;
  @override
  Widget build(BuildContext context) {
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



