import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';


final onboardingTextIndexProvider = StateNotifierProvider.autoDispose<OnboardingText,int>((ref)=> OnboardingText());


class OnboardingText extends StateNotifier<int>{
  final List<String> textChoices = ["Test out your knowledge", "Tease your brain", "Pump your brain"];
  
  Timer? _timer;

  OnboardingText():super(0){
    timer();
  }

  void timer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      state = (state + 1) % textChoices.length;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
}
