import 'package:brainlytic/screens/auth/lineorline.dart';
import 'package:brainlytic/screens/auth/login_username.dart';
import 'package:brainlytic/screens/auth/signingithub.dart';
import 'package:brainlytic/screens/auth/signingoogle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose(); 
    nameController.dispose();
    super.dispose();
  }

  Future<void> createUserData() async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      
      if(user!=null){
        await FirebaseFirestore.instance.collection('userData').doc(user.uid).set({"uid": user.uid});
        
        for(int i=1; i<=8; i++){
          await FirebaseFirestore.instance.collection("userData").doc(user.uid).
          collection('quizData').doc("quiz$i").set({
            "stars": 0,
            "id": i
          });
        }
      }
      
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString(),
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

  Future<bool> createUser() async{
    try{
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
      await userCredential.user!.updateDisplayName(nameController.text.trim());
      await createUserData();

      return true;
    }on FirebaseAuthException catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right:8, bottom:4),
                child: const Text("Brainlytic",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(19),
                child: const Text("Create an account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
                width: 400,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    labelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.grey.shade600
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.indigoAccent.shade400
                    ),
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
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
                width: 400,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    labelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.grey.shade600
                    ),
                    floatingLabelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.indigoAccent.shade400
                    ),
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
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
                width: 400,
                child: TextField(
                  obscureText: isVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    labelStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.grey.shade600
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
                    )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,right: 16, top: 16, bottom: 4),
                width: 335,
                height: 77,
                child: ElevatedButton(
                  onPressed: ()async{
                    if(nameController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Name cannot be empty",
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        )
                      );
                    }
                    else if(emailController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("E-mail cannot be empty",
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        )
                      );
                    }
                    else if(passwordController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
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
                      bool isCreated = await createUser();
                      if(isCreated){
                        if(context.mounted){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => LoginUsername()));
                       }
                      }
                    }
                  }, 
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                    elevation: WidgetStatePropertyAll(4)
                  ),
                  child: Text("Continue",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                    ),
                  )
                ),
              ),
              const Lineorline(),
              const SigninGoogle(),
              const SigninGitHub(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginUsername()
                        )
                      );
                    }, 
                    child: Text("Log in",
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