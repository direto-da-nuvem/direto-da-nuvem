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

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedItem = "Dashboard";

  final Images = ["assets/photos/cat.jpg","assets/photos/rocket.jpg","assets/photos/lake.jpg"];


  void being_logout(){
    try{
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    Get.offAndToNamed(Routes.LOGIN);
    }catch(error){}
    Get.offAndToNamed(Routes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: Get.put(DashboardController()),
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(
            title:
            Text("DiretoDaUff"),
            centerTitle: false,
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Image.asset(Images[current_image]),
                CarouselSlider.builder(
                  options: CarouselOptions(height: 300, autoPlay: true, autoPlayInterval: Duration(seconds: 5), viewportFraction: 1, autoPlayAnimationDuration: Duration(milliseconds: 350),),
                  itemCount: Images.length,
                  itemBuilder: (context,index,realIndex){
                    final cImage = Images[index];
                    return Image.asset(cImage, scale: 10);
                  },
                ),
                GetBuilder<LoginController>(
                    init: Get.put(LoginController()),
                    builder: (loginController) {
                      return Column(
                        children: [
                          Text(''),
                          Text('   Current User:   ' + loginController.auth.currentUser!.displayName!),
                           Text('   Current Email:   ' + loginController.auth.currentUser!.email!),
                          Text(''),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ElevatedButton(onPressed: () => being_logout(), child: Text('Logout')),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.start,
                      );
                    }
                )

                //da code goes here

              ],
            ),
          );

      }
    );
  }
}


