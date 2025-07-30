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
      appBar: AppBar(
        toolbarHeight: 23,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Brainlytic",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 35),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Welcome Back!",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                //color: Colors.blue
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 340,
              height: 60,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return LoginPassword(
                        email: emailController.text
                      );
                    }
                  ));
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
    );
  }
}