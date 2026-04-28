import 'package:brainlytic/screens/auth/lineorline.dart';
import 'package:brainlytic/screens/auth/login_password.dart';
import 'package:brainlytic/screens/auth/register.dart';
import 'package:brainlytic/screens/auth/signingithub.dart';
import 'package:brainlytic/screens/auth/signingoogle.dart';

import 'package:flutter/material.dart';


class LoginUsername extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  LoginUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              const Text("Brainlytic",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text("Welcome Back!",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 15, bottom: 16),
                width: 400,
                child: TextField(
                  controller: emailController,
                  autofocus: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Colors.indigoAccent.shade400,
                        width: 1.5
                      )
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 20
                    ),
                    enabled: true,
                  ),
                  style: TextStyle(
                    fontSize: 19
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 340,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async{
                      if(emailController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("E-mail cannot be empty",
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        );
                      }
                      else{
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return LoginPassword(
                            email: emailController.text
                          );
                        }
                      ));
                      }
                      
                    }, 
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    child: Text("Continue",
                      style: TextStyle(
                        fontSize: 21.3,
                        color: Colors.white
                      ),
                    )
                  ),
                ),
              ),
              const Lineorline(),
              const SigninGoogle(),
              const SigninGitHub(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Register();
                        }
                      ));
                    }, 
                    child: Text("Sign up",
                      style: TextStyle(
                        color: Color.fromRGBO(102, 110, 169, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(102, 110, 169, 1),
                        fontSize: 17
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}