

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentQuestionProvider =
    NotifierProvider.autoDispose<CurrentQuestion, int>(CurrentQuestion.new);

class CurrentQuestion extends Notifier<int>{
  @override
  int build() => 1;

  void increment(){
    state++;
  }

  void reset(){
    state = 1;
  }
}