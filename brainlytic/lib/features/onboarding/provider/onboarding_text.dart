import 'package:flutter_riverpod/legacy.dart';

final onboardingTextIndexProvider = StateNotifierProvider.autoDispose<OnboardingText, OnboardingTextState>((ref) => OnboardingText());

class OnboardingTextState {
  final int index;
  final bool isDeleting;
  const OnboardingTextState({required this.index, required this.isDeleting});
}

class OnboardingText extends StateNotifier<OnboardingTextState> {
  final List<String> textChoices = ["Tease your brain", "Pump your brain", "Test out your knowledge"];

  OnboardingText() : super(const OnboardingTextState(index: 0, isDeleting: false));

  String get currentText => textChoices[state.index];

  void startDeleting() {
    state = OnboardingTextState(index: state.index, isDeleting: true);
  }

  void nextText() {
    final nextIndex = (state.index + 1) % textChoices.length;
    state = OnboardingTextState(index: nextIndex, isDeleting: false);
  }
}