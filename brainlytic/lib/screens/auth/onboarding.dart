import 'package:brainlytic/screens/auth/login_username.dart';
import 'package:brainlytic/screens/auth/register.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50) ,topRight:Radius.circular(50))
            ),
            width: double.infinity,
            height: 450,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35,left: 16,right: 16, bottom: 8),
                  padding: EdgeInsets.only(top: 20,left: 14,right: 14,bottom: 10),
                  child: Text(" Welcome to Brainlytic ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 37,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text("Test out your knowledge",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 19
                  ),
                ),
                SizedBox(height: 19,),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    width: 310,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context){
                              return LoginUsername();
                            }
                          )
                        );
                      }, 
                      child: Text("Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: 310,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context){
                          return Register();
                        }
                        )
                      );
                    }, 
                    child: Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ],
      ), 
    );
  }
}