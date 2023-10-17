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

  final Set<Image> imageAssets = {};
  final Set<String> RequestedImages = {"cat.jpg","rocket.jpg","lake.jpg"};

  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;


  Future<void> getImageData() async {
    for(String s in RequestedImages){
      dynamic i = await storage.ref().child(s).getData();
      Image im = Image.memory(i,fit:BoxFit.cover);
      imageAssets.add(im);
      developer.log("mine: FINISHED LOADING IMAGE $s");}
    finishedLoading();
    return;
  }
  //final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];
  void goBack(){
    Get.offAndToNamed(Routes.DASHBOARD);
  }

  void finishedLoading(){setState(() {
    isLoading = false;
  });}

  @override
  Widget build(BuildContext context) {
    getImageData();
    //while(showcaseController.isLoading){}
    final tempImages = imageAssets.toList();

    return Scaffold(
      backgroundColor: Colors.black38,
      body: isLoading ? const Center(child: CircularProgressIndicator()) : GestureDetector(
        onDoubleTap: ()=>goBack(),
        child: CarouselSlider.builder(
          options: CarouselOptions(height: 500, autoPlay: true, autoPlayInterval: Duration(seconds: 5), viewportFraction: 1, autoPlayAnimationDuration: Duration(milliseconds: 350),),
          itemCount: imageAssets.length,
          itemBuilder: (context,index,realIndex){
            return tempImages[index];
            },
        ),
      ),
    );
  }
}



