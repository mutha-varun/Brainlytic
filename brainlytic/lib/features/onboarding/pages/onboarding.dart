import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/onboarding/provider/onboarding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


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

    final size = MediaQuery.of(context).size;

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
                style: Theme.of(context).textTheme.headlineLarge,
              );
            },
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Pallete.blackColor,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(50) ,topRight:Radius.circular(50))
            ),
            width: double.infinity,
            height: 370,
            child: Column(
              children: [
                const Spacer(flex: 2,),
                Text("Welcome to Brainlytic",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    context.pushNamed(RouteConstants.loginUsername);
                  }, 
                  child: const Text("Login")
                ),
                const SizedBox(height: 20,),
                OutlinedButton(
                  onPressed: (){
                    context.pushNamed(RouteConstants.register);
                  }, 
                  child:  Text("Register",)
                ),
                const Spacer(flex: 2,)
              ],
            ),
          ),
        ],
      ), 
    );
  }
}