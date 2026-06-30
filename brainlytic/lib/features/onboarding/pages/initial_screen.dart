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
          const Spacer(flex: 5,),
          Image.asset("assets/initial_screen.png",
            width: width,
            height: 180,
            alignment: AlignmentGeometry.center,
          ),
          const Spacer(),
          Text("Give it a jolt!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium
          ),
          const Spacer(flex: 2,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(width-45, 57),
              textStyle: Theme.of(context).textTheme.titleLarge,
              shape: StadiumBorder(),
              alignment: Alignment.center
            ),
            onPressed: (){
             context.pushNamed(RouteConstants.onboarding);
            }, 
            child: const Text("Next")
          ),
          const Spacer(flex: 4,)
        ],
      ),
    );
  }
}