import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/utility/utils.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/auth/pages/widgets/appname.dart';
import 'package:brainlytic/features/auth/pages/widgets/button.dart';
import 'package:brainlytic/features/auth/pages/widgets/customtextfield.dart';
import 'package:brainlytic/features/auth/pages/widgets/lineorline.dart';
import 'package:brainlytic/features/auth/pages/widgets/passwordtextfield.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingithub.dart';
import 'package:brainlytic/features/auth/pages/widgets/signingoogle.dart';
import 'package:brainlytic/features/auth/pages/widgets/questiontext.dart';
import 'package:brainlytic/features/auth/provider/isobscured.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
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
                return showSnackBar(context, state.message);
              }
              if(state is AuthSuccess){
                context.replaceNamed(RouteConstants.loginUsername);
              }
            },
            builder: (context, state) {
              return Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Appname(displayText: "Create an account"),
                    Customtextfield(
                      controller: nameController, 
                      text: "Name",
                      autofocus: true,
                    ),
                    Customtextfield(
                      controller: emailController, 
                      text: "Email"
                    ),
                    Consumer(
                      builder: (context, ref, child){
                        bool isObscured = ref.watch(isObscuredProvider);
                        return Passwordtextfield(
                          controller: passwordController, 
                          isObscured: isObscured,
                          onTap: (){
                            ref.read(isObscuredProvider.notifier).state = !isObscured;
                          }
                        );
                      },
                    ),
                    const SizedBox(height: 25,),
                    state is AuthLoading?
                    const Circularindicator()
                    :
                    Button(
                      onTap: () async {
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
                    SigninGoogle(state: state,),
                    const SizedBox(height: 20,),
                    SigninGitHub(state: state,),
                    const SizedBox(height: 15,),
                    Questiontext(
                      text: "Already have an account?",
                      buttonText: "Log in",
                      onTap: (){
                        final container = ProviderScope.containerOf(context);
                        container.read(isObscuredProvider.notifier).state = true;
                        context.replaceNamed(RouteConstants.loginUsername);
                      }
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
