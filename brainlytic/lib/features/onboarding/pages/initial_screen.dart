import 'package:brainlytic/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2,),
          Image.asset("assets/initial_screen.png",
            width: width,
            height: 180,
          ),
          const Spacer(),
          Text("Give it a jolt!",
            style: Theme.of(context).textTheme.displayLarge
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(width-30, 55),
              textStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500
              ),
              shape: StadiumBorder()
            ),
            onPressed: (){
             context.pushNamed(RouteConstants.onboarding);
            }, 
            child: const Text("Next")
          ),
          const Spacer(flex: 2,)
        ],
      ),
    );
  }
}