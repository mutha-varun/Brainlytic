import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/pages/widgets/appname.dart';
import 'package:brainlytic/features/auth/pages/widgets/button.dart';
import 'package:brainlytic/features/auth/pages/widgets/customtextfield.dart';
import 'package:brainlytic/features/auth/pages/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingithub.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingoogle.dart';
import 'package:brainlytic/features/auth/pages/widgets/questiontext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LoginUsername extends StatefulWidget {
  final String? email;
  const LoginUsername({this.email = "", super.key});

  @override
  State<LoginUsername> createState() => _LoginUsernameState();
}

class _LoginUsernameState extends State<LoginUsername> {
  late final TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Appname(displayText: "Welcome Back!"),
                Customtextfield(
                  controller: emailController,
                  autofocus: true,
                  text: "Email",
                ),
                const SizedBox(height: 15,),
                Button(
                  onTap: () async{
                    // if(emailController.text.isEmpty){
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text("E-mail cannot be empty",
                    //       textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           fontSize: 18
                    //         ),
                    //       )
                    //     )
                    //   );
                    // }
                    // else{
                    //   context.pushNamed(RouteConstants.loginPassword);
                    // }
                    if(formKey.currentState!.validate()){
                      context.pushNamed(
                        RouteConstants.loginPassword,
                        queryParameters: {
                          "email": emailController.text.trim()
                        }
                      );
                    }
                  }
                ),
                const Lineorline(),
                const SizedBox(height: 20,),
                const SigninGoogle(),
                const SizedBox(height: 20,),
                const SigninGitHub(),
                const SizedBox(height: 15,),
                Questiontext(
                  text: "Don't have an account?", 
                  buttonText: "Sign up", 
                  onTap:  (){
                    context.replaceNamed(RouteConstants.register);
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}