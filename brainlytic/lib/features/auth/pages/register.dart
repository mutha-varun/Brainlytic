import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/auth/pages/widgets/appname.dart';
import 'package:brainlytic/features/auth/pages/widgets/button.dart';
import 'package:brainlytic/features/auth/pages/widgets/customtextfield.dart';
import 'package:brainlytic/features/auth/pages/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingithub.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingoogle.dart';
import 'package:brainlytic/features/auth/pages/widgets/questiontext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isObscured = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    isObscured = true;
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
              style: TextStyle(fontSize: 18),
            ),
          ),
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthFailure){
                return ;
              }
              if(state is AuthSuccess){
                context.replaceNamed(RouteConstants.loginUsername);
              }
            },
            builder: (context, state) {
              if(state is AuthLoading){
               //Later add circular indicator widget after merging 
              }
              return Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Appname(displayText: "Create an account"),
                    Customtextfield(
                      controller: nameController, 
                      text: "Name"
                    ),
                    Customtextfield(
                      controller: emailController, 
                      text: "Email"
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16,right: 16, top: 10, bottom: 16),
                      width: 360,
                      height: 60,
                      child: TextFormField(
                        obscureText: isObscured,
                        controller: passwordController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("Password"),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            icon: Icon(isObscured? Icons.visibility : Icons.visibility_off,
                              size: 30,
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Button(
                      onTap: () async {
                        // if (nameController.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         "Name cannot be empty",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(fontSize: 18),
                        //       ),
                        //     ),
                        //   );
                        // } else if (emailController.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         "E-mail cannot be empty",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(fontSize: 18),
                        //       ),
                        //     ), 
                        //   );
                        // } else if (passwordController.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         "Password is required",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(fontSize: 18),
                        //       ),
                        //     ),
                        //   );
                        // } else {
                        //   bool isCreated = await createUser();
                        //   if (isCreated) {
                        //     if (context.mounted) {
                        //       context.replaceNamed(
                        //         RouteConstants.loginUsername,
                        //       );
                        //     }
                        //   }
                        // }
                        if(formkey.currentState!.validate()){
                          context.read<AuthBloc>().add(
                            RegisterEvent(
                              name: nameController.text.trim(), 
                              email: emailController.text.trim(), 
                              password: passwordController.text.trim()
                            )
                          );
                        }
                      },
                    ),
                    const Lineorline(),
                    const SizedBox(height: 20,),
                    const SigninGoogle(),
                    const SizedBox(height: 20,),
                    const SigninGitHub(),
                    const SizedBox(height: 15,),
                    Questiontext(
                      text: "Already have an account?",
                      buttonText: "Log in",
                      onTap: ()=> context.pushNamed(RouteConstants.loginUsername)
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
