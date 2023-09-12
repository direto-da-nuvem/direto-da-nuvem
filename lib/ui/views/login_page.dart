import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: Get.put(LoginController()),
      builder: (loginController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sample for Science'),
            centerTitle: true,
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: loginController.signInWithGoogle,
              child: const SizedBox(
                height: 50,
                width: 180,
                child: Center(
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 15,),
                      Text("Sign in with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      }
    );
  }
}
