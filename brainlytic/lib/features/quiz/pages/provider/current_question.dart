

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentQuestionProvider = NotifierProvider(()=>CurrentQuestion());

class CurrentQuestion extends Notifier<int>{
  @override
  int build() => 1;

  void increment(){
    state++;
  }
}