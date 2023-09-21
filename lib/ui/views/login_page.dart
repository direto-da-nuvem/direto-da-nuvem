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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                        width: 500,
                        color: Colors.white,
                        child: Image.asset("assets/logo.png")),
                    SizedBox(
                      width: double.infinity,
                    )]
                ),
              )


            )
          )
        );
      }
    );
  }
}

//ElevatedButton(
//                       onPressed: loginController.signInWithGoogle,
//                       child: const SizedBox(
//                         height: 50,
//                         width: 200,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(FontAwesomeIcons.google),
//                             SizedBox(width: 15,),
//                             Text("Sign in with Google",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500
//                                 )
//                             ),
//                           ],
//                         ),
//                       ),
//                     )