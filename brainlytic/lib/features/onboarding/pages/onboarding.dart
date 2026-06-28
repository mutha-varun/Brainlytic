import 'package:brainlytic/features/auth/login_username.dart';
import 'package:brainlytic/features/auth/register.dart';
import 'package:brainlytic/features/onboarding/provider/onboarding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key});

  @override
  ConsumerState<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> with SingleTickerProviderStateMixin{
  final Duration _typeDuration = const Duration(milliseconds: 2700);
  final Duration _deleteDuration = const Duration(milliseconds: 1500);

  late AnimationController _controller;
  late Animation<int> _charCountAnim;
  OnboardingTextState? _prevProviderState;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _typeDuration);
    _controller.addStatusListener(_onAnimationStatus);

    final notifier = ref.read(onboardingTextIndexProvider.notifier);
    final text = notifier.textChoices[0];
    _charCountAnim = IntTween(begin: 0, end: text.length)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

   
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward(from: 0);
    });
  }
  void _onAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;

    final notifier = ref.read(onboardingTextIndexProvider.notifier);
    final state = ref.read(onboardingTextIndexProvider);

    if (!state.isDeleting) {
      notifier.startDeleting();
    } else {
      notifier.nextText();
    }
  }

  void _rebuildAnimation(OnboardingTextState providerState, String text) {
    final isDeleting = providerState.isDeleting;
    _controller.duration = isDeleting ? _deleteDuration : _typeDuration;
    _charCountAnim = IntTween(
      begin: isDeleting ? text.length : 0,
      end: isDeleting ? 0 : text.length,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: isDeleting ? Curves.easeIn : Curves.easeOut,
    ));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final providerState = ref.watch(onboardingTextIndexProvider);
    final notifier = ref.read(onboardingTextIndexProvider.notifier);
    final text = notifier.textChoices[providerState.index];

   
    if (_prevProviderState?.index != providerState.index ||
        _prevProviderState?.isDeleting != providerState.isDeleting) {
      _prevProviderState = providerState;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _rebuildAnimation(providerState, text);
      });
    }
  
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final count = _charCountAnim.value.clamp(0, text.length);
              return Text(
                text.substring(0, count),
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.displayLarge,
              );
            },
          ),
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50) ,topRight:Radius.circular(50))
            ),
            width: double.infinity,
            height: 400,
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Text(" Welcome to Brainlytic ",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge
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
                    child:  Text("Register",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white
                      )
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