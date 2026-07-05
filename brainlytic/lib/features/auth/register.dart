import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/signingithub.dart';
import 'package:brainlytic/features/auth/signingoogle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25,),
              Text("Brainlytic",
                style: Theme.of(context).textTheme.titleLarge
              ),
              const SizedBox(height: 30,),
              Text("Create an account",
                style: Theme.of(context).textTheme.headlineLarge
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.only(left: 16,right: 16, top: 15, bottom: 10),
                width: 360,
                height: 60,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Name"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16,right: 16, top: 10, bottom: 10),
                width: 360,
                height: 60,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text("Email"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16,right: 16, top: 10, bottom: 16),
                width: 360,
                height: 60,
                child: TextField(
                  obscureText: isVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: Text("Password"),
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
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
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
                        context.replaceNamed(RouteConstants.loginUsername);
                     }  
                    }
                  }
                }, 
                child: Text("Continue",)
              ),
              const Lineorline(),
              const SizedBox(height: 20,),
              const SigninGoogle(),
              const SizedBox(height: 20,),
              const SigninGitHub(),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      letterSpacing: -0.2
                    )
                  ),
                  TextButton(
                    onPressed: (){
                      context.pushNamed(RouteConstants.loginUsername);
                    }, 
                    child: Text("Log in",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Pallete.indigo700Color,
                        decoration: TextDecoration.underline,
                        letterSpacing: -0.2
                      )
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