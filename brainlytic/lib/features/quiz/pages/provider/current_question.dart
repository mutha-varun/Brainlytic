

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentQuestionProvider =
    NotifierProvider.autoDispose<CurrentQuestion, int>(CurrentQuestion.new);

class CurrentQuestion extends Notifier<int>{
  @override
  int build() => 0;

  void increment(){
    state++;
  }

  void reset(){
    state = 0;
  }
}