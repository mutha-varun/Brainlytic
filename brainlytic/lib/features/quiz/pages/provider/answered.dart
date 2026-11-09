import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAnswered =
    NotifierProvider.autoDispose<Answered, bool>(Answered.new);

class Answered extends Notifier<bool>{
  @override
  bool build()=>false;

  void answered(){
    state = true;
  }

  void reset() {
    state = false;
  }
}