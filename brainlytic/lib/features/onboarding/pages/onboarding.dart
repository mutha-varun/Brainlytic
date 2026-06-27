import 'package:brainlytic/features/auth/login_username.dart';
import 'package:brainlytic/features/auth/register.dart';
import 'package:brainlytic/features/onboarding/provider/onboarding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Onboarding extends ConsumerWidget {
  const Onboarding({super.key});

  Widget _buildAnimation(BuildContext context,String text, int index){
  
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),

        );
      },
      child: Text(
          text,
          key: ValueKey<int>(index), 
          style: Theme.of(context).textTheme.displayLarge
        ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(onboardingTextIndexProvider);

    final notifier = ref.read(onboardingTextIndexProvider.notifier);
    final text = notifier.textChoices[index];

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          const Spacer(),
          _buildAnimation(context,text, index),
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50) ,topRight:Radius.circular(50))
            ),
            width: double.infinity,
            height: 450,
            child: Column(
              children: [
                const SizedBox(height: 55,),
                const Text(" Welcome to Brainlytic ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 37,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                const Text("Test out your knowledge",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 19
                  ),
                ),
                const SizedBox(height: 19,),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    width: 310,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context){
                        //       return LoginUsername();
                        //     }
                        //   )
                        // );
                      }, 
                      child: const Text("Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 310,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: (){
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context){
                      //       return const Register();
                      //     }
                      //   )
                      // );
                    }, 
                    child: const Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ],
      ), 
    );
  }
}