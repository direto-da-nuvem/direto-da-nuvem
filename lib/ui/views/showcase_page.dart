import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/dashboard_controller.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:sample/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sample/routes/app_pages.dart';

// Itens do popMenuButton
enum MenuItem { itemOne }

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({Key? key}) : super(key: key);

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  String selectedItem = "ShowcasePage";

  final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];
  void goBack(){
    Get.offAndToNamed(Routes.DASHBOARD);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: GestureDetector(
        onDoubleTap: ()=>goBack(),
        child: CarouselSlider.builder(
          options: CarouselOptions(height: 500, autoPlay: true, autoPlayInterval: Duration(seconds: 5), viewportFraction: 1, autoPlayAnimationDuration: Duration(milliseconds: 350),),
          itemCount: Images.length,
          itemBuilder: (context,index,realIndex){
            final cImage = Images[index];
            return Image.asset(cImage, scale: 1);
          },
        ),
      ),
      );
  }
}


