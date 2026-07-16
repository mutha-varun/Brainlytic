import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/auth/pages/widgets/appname.dart';
import 'package:brainlytic/features/auth/pages/widgets/button.dart';
import 'package:brainlytic/features/auth/pages/widgets/forgotpassword.dart';
import 'package:brainlytic/features/auth/pages/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingithub.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingoogle.dart';
import 'package:brainlytic/features/auth/pages/widgets/questiontext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  bool isObscured = false;
  late final TextEditingController emailController;
  final passwordController = TextEditingController();
  final recoveryEmail = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isObscured = true;
    emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  Future<void> loginUser() async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: widget.email, //change this to widegt.email
        password: passwordController.text.trim(),
      );
      if (mounted) {
        context.goNamed(RouteConstants.home);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  Future<void> resetPasswordDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Pallete.scaffoldColor,
          contentPadding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: 0,
          ),
          content: SizedBox(
            width: 360,
            height: 140,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(label: Text("Email")),
                  autofocus: true,
                  controller: recoveryEmail,
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (recoveryEmail.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Email is required",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                          resetPassword();
                        }
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        recoveryEmail.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> resetPassword() async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: recoveryEmail.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Mail sent",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      } else if (e.code == 'invalid-email' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
      recoveryEmail.clear();
      throw Exception(e.message);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthFailure){
                //add snackbar
              }
              if(state is AuthSuccess){
                context.goNamed(RouteConstants.home);
              }
            },
            builder: (context, state) {
              if(state is AuthLoading){
                // Add circular indicator
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Appname(displayText: "Enter password"),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 15,
                        bottom: 10
                      ),
                      width: 360,
                      child: TextFormField(
                        readOnly: true,
                        focusNode: _focusNode,
                        onTap: () => _focusNode.unfocus(),
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          floatingLabelStyle: TextStyle(
                            color: Pallete.enabledBorderColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () { 
                              context.pop();
                              context.replaceNamed(
                                RouteConstants.loginUsername,
                                queryParameters: {"email": widget.email},
                              );
                            },
                            icon: const Icon(Icons.edit, size: 25),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 15,
                      ),
                      width: 360,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: isObscured,
                        autofocus: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 30,
                            ),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    ForgotPassword(
                      onTap: () async => await resetPasswordDialog(),
                    ),
                    Button(
                      onTap: () async {
                        // if(passwordController.text.isEmpty){
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text("Password is required",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 18
                        //         ),
                        //       )
                        //     )
                        //   );
                        // }
                        // else{
                        //   await loginUser();
                        // }
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginEvent(
                              email: widget.email,
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                    const Lineorline(),
                    const SizedBox(height: 20),
                    const SigninGoogle(),
                    const SizedBox(height: 20),
                    const SigninGitHub(),
                    const SizedBox(height: 15),
                    Questiontext(
                      text: "Don't have an account?",
                      buttonText: "Sign up",
                      onTap: () {
                        context.replaceNamed(RouteConstants.register);
                      },
                    ),
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
