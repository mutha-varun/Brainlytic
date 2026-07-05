import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/widgets/appname.dart';
import 'package:brainlytic/features/auth/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/signingithub.dart';
import 'package:brainlytic/features/auth/signingoogle.dart';
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
              ElevatedButton(
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
                    context.pushNamed(RouteConstants.loginPassword);
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
                  Text("Don't have an account?",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      letterSpacing: -0.2
                    )
                  ),
                  TextButton(
                    onPressed: (){
                      context.replaceNamed(RouteConstants.register);
                    }, 
                    child: Text("Sign up",
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