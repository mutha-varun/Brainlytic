import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/widgets/appname.dart';
import 'package:brainlytic/features/auth/widgets/button.dart';
import 'package:brainlytic/features/auth/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/signingithub.dart';
import 'package:brainlytic/features/auth/signingoogle.dart';
import 'package:brainlytic/features/auth/widgets/questiontext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class LoginUsername extends StatefulWidget {
  final String? text;
  const LoginUsername({this.text = "", super.key});

  @override
  State<LoginUsername> createState() => _LoginUsernameState();
}

class _LoginUsernameState extends State<LoginUsername> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.text);
    super.initState();
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
              Appname(displayText: "Welcome Back!"),
              Container(
                margin: const EdgeInsets.only(left: 16,right: 16, top: 15, bottom: 16),
                width: 360,
                height: 60,
                child: TextField(
                  controller: emailController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  style: Theme.of(context).textTheme.bodyLarge
                ),
              ),
              const SizedBox(height: 15,),
              Button(
                onTap: () async{
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
                    context.pushNamed(RouteConstants.loginPassword);
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
    );
  }
}