import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sample/controllers/dashboard_controller.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:sample/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() {return _LoginPageState();}
}


class _LoginPageState extends State<LoginPage> {


  bool deviceConfigured = Get.arguments;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {

    return isLoading? Center(child: CircularProgressIndicator()): GetBuilder<LoginController>(
      init: Get.put(LoginController()),
      builder: (loginController) {
        print(deviceConfigured);
        print(Get.arguments);
        loginController.setDeviceConfigured(deviceConfigured);
        return Scaffold(
          appBar: AppBar(toolbarHeight: 10,),
          body: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(100, 199, 209, 241), // Cor da borda vermelha
                  width: 16.0, // Largura da borda
                ),

                borderRadius: BorderRadius.circular(20.0)

              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                        padding: const EdgeInsets.fromLTRB(15,0,0,0),
                        child: SvgPicture.asset(
                          "assets/logo.svg",
                          width: 190)),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Log in:',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 25, fontFamily: 'Arial')
                              ),
                            ),
                          ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2,0,2,0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
                              ),
                            ),

                            onPressed: loginController.signInWithGoogle,
                            child: const SizedBox(
                              height: 50,
                              width: 450,
                              child: SizedBox(
                                //width:0,
                                //height: 10,
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(width: 100),
                                  Icon(FontAwesomeIcons.google),
                                  Text("Sign in with Google",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                  SizedBox(width: 100),
                                ],
                              ),)
                            ),
                          ),
                        ),
                    ],

                  ),
                  ]
                ),
              )
            )
          )
        );
      }
    );
  }
}

