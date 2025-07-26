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
  
  @override
  void initState() {
    isVisible = true;
    super.initState();
  } 

  Future<void> loginUser() async {
    // Implement login logic here
    try{
      final userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.email, password: passwordController.text.trim()
      );
      if(mounted) {
        Navigator.pushReplacement(context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(name: userCredential.user!.displayName!))
        );
      }
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 23,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Brainlytic",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 5),
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Text("Enter your password",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 13),
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
            icon: Icon(Icons.edit,
                size: 26,
              )
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
            width: 400,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                label: Text(widget.email,
                  style: TextStyle(
                    fontSize: 20
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
            padding: EdgeInsets.only(left: 16,right: 16, top: 10, bottom: 16),
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
            margin: EdgeInsets.only(right: 12, bottom: 16),
            child: TextButton(
              onPressed: () {
               
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
                  await loginUser();
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
    );
  }
}