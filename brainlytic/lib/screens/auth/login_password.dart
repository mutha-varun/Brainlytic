import 'package:brainlytic/screens/auth/lineorline.dart';
import 'package:brainlytic/screens/auth/register.dart';
import 'package:brainlytic/screens/auth/signingithub.dart';
import 'package:brainlytic/screens/auth/signingoogle.dart';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPassword extends StatefulWidget {
  final String email;
  const LoginPassword({
    super.key,
    required this.email
  });

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {

  bool showPasswordField = false;
  bool isVisible = false;
  final passwordController = TextEditingController();
  final recoveryEmail = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  @override
  void initState() {
    isVisible = true;
    super.initState();
  } 

  Future<void> loginUser() async {
    try{
      final userCredential =  await _firebaseAuth.signInWithEmailAndPassword(
        email: widget.email, password: passwordController.text.trim()
      );
      if(mounted) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(
            builder: (context) => HomeScreen())
        );
      }
    } on FirebaseAuthException catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      }
      
    }
  }


  Future<void> resetPasswordDialog() async{
    await showDialog<void>(context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
          content: SizedBox(
            height: 140,
            width: 270,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    label: Text("Email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.indigoAccent.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.indigoAccent.shade400,
                      )
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.indigoAccent.shade400
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  autofocus: true, 
                  controller: recoveryEmail, 
                  obscureText: false,
                ),
                SizedBox(height: 22,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        if(recoveryEmail.text.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password is required",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                            )
                          );
                        }
                        else{
                          Navigator.of(context).pop();
                          resetPassword();
                        }
                      }, 
                      child: Text("Send",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue
                        ),
                      )
                    ),
                    TextButton(
                      onPressed: (){
                        recoveryEmail.clear();
                        Navigator.of(context).pop();
                      }, 
                      child: Text("Close",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red
                        ),
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Future<void> resetPassword() async{
    try{ 
      await _firebaseAuth.sendPasswordResetEmail(email: recoveryEmail.text.trim());
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Mail sent",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              )
            )
          )
        );
      }
    } on FirebaseAuthException catch(e){

      if (e.code == 'user-not-found' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      } 
      else if (e.code == 'invalid-email' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      }
      recoveryEmail.clear();
      throw Exception(e.message);
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }

    recoveryEmail.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 27,),
              Text("Brainlytic",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 27, bottom: 5),
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Text("Enter your password",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 5, bottom: 16),
                    width: 350,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        label: Text(widget.email,
                          style: TextStyle(
                            fontSize: 19
                          )
                        ),
                        labelStyle: TextStyle(
                          fontSize: 19,
                          color: Colors.grey.shade600
                        ),
                        floatingLabelStyle: TextStyle(
                          fontSize: 19,
                          color: Colors.indigoAccent.shade400
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            style: BorderStyle.solid,
                            width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.edit,
                        size: 27,
                      )
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 10, bottom: 10),
                width: 400,
                child: TextField(
                  controller: passwordController,
                  obscureText: isVisible,
                  autofocus: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 20
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.indigoAccent.shade400
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(isVisible? Icons.visibility : Icons.visibility_off,
                        size: 30,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Colors.indigoAccent.shade400,
                          width: 1.5
                      )
                    ),
                  ),
                )
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 12, bottom: 10),
                child: TextButton(
                  onPressed: () async{
                    await resetPasswordDialog();
                  }, 
                  child: Text("Forgot Password?",
                    style: TextStyle(
                      color: Colors.indigoAccent.shade700,
                      fontSize: 17
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top:6),
                child: SizedBox(
                  width: 340,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(passwordController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password is required",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          )
                        );
                      }
                      else{
                        await loginUser();
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
              Lineorline(),
              SigninGoogle(),
              SigninGitHub(),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register()
                        )
                      );
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