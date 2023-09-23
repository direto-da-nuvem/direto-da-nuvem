import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:sample/routes/app_pages.dart';



class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
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
                      child: Text(
                        'Log in To Sample',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 30, fontFamily: 'Arial')
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email', // Rótulo do campo
                         // Dica de texto
                        // Outros atributos de estilo, como prefixIcon, suffixIcon, etc.
                      ),
                      // Controlador de texto, manipulador de eventos e outras propriedades podem ser definidos aqui
                    )


                  ),
                  SizedBox(
                        width: double.infinity,
                        child: TextField(
                          decoration: InputDecoration(
                             // Rótulo do campo
                            hintText: 'Password', // Dica de texto
                            // Outros atributos de estilo, como prefixIcon, suffixIcon, etc.
                          ),
                          // Controlador de texto, manipulador de eventos e outras propriedades podem ser definidos aqui
                        )


                    ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [

                            Checkbox(
                                value: isChecked,
                                onChanged: (newBool){
                                  setState(() {
                                    isChecked = newBool!;
                                  });
                                }, ),
                            Text(
                                'Remember me?',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18, fontFamily: 'Arial')
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(100, 240, 217, 220), // Cor de fundo verde
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
                            ),
                          ),
                          onPressed: (){print('forgotten password clicado');},
                          child: const SizedBox(
                            height: 30,
                            width: 120,
                            child:
                                Center(
                                  child: Text("Forgotten Password?",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),


                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(100,180,232,199), // Cor de fundo verde
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
                          ),
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed(Routes.DASHBOARD);

                        },
                        child: const SizedBox(
                          height: 50,
                          width: double.infinity,
                          child:
                          Center(
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),


                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Cor de fundo azul
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
                        ),
                      ),

                        onPressed: loginController.signInWithGoogle,
                        child: const SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(100, 240, 217, 220), // Cor de fundo verde
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // Define o raio das bordas
                              ),
                            ),
                            onPressed: (){print('Sign Up Clicado');},
                            child: const SizedBox(
                              height: 15,
                              width: 60,
                              child:
                              Center(
                                child: Text("Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),


                            ),
                          ),
                        ],
                      ),
                    )


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

