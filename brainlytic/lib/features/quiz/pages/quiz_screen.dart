import 'dart:async';
import 'package:brainlytic/core/utility/utils.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:brainlytic/features/quiz/pages/bloc/quiz_bloc.dart';
import 'package:brainlytic/features/quiz/pages/provider/answered.dart';
import 'package:brainlytic/features/quiz/pages/provider/current_question.dart';
import 'package:brainlytic/features/quiz/pages/widgets/completed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/quiz/pages/widgets/answer_tile.dart';
import 'package:brainlytic/features/quiz/pages/widgets/question_tile.dart';
import 'package:flutter/material.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final String qid;
  const QuizScreen({required this.qid, super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  late int _answerIndex;
  int _score = 0;
  late int _selectedIndex;
  Timer? _nextQuestionTimer;
  late int _length;

  @override
  void initState() {
    super.initState();
    context.read<QuizBloc>().add(FirstQuestion(quizId: widget.qid));
  }

  @override
  void dispose() {
    _nextQuestionTimer?.cancel();
    super.dispose();
  }

  Color getColor(int index, bool answered){
    if(!answered){
      return Pallete.blackColor;
    }

    if(index == _answerIndex){
      return Pallete.correctAnsColor;
    }

    if(index == _selectedIndex){
      return Pallete.redColor;
    }

    return Pallete.blackColor;
  }

  void _nextQuestion() {
    _nextQuestionTimer?.cancel();
    _nextQuestionTimer = Timer(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      ref.read(isAnswered.notifier).reset();

      if(ref.read(currentQuestionProvider) == _length){
        context.read<QuizBloc>().add(QuizEnd(quizId: widget.qid, score: _score));
        showDialog(
          context: context, 
          builder: (context){
            return Completed(score: _score, length: _length);
          }
        );
      }
      else{
        ref.read(currentQuestionProvider.notifier).increment();
      }
    });
  }

  void _checkAnswer(){
    ref.read(isAnswered.notifier).answered();

    if(_selectedIndex==_answerIndex){
      _score++;
    } 
    
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    int currentQuestionIndex = ref.watch(currentQuestionProvider);
    final answered = ref.watch(isAnswered);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Question ${currentQuestionIndex+1}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        toolbarHeight: 55,
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if(state is QuizFetchError){
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if(state is QuizLoading){
            return Circularindicator();
          }

          if(state is QuizFetchError){
            return Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  context.read<QuizBloc>().add(FirstQuestion(quizId: widget.qid));
                }, 
                icon: Icon(Icons.refresh),
                label: Text("Retry"),
              ),
            );
          }

          if(state is QuizFetched){
            final question = state.questions[currentQuestionIndex].question;
            _length = state.questions.length;
            final options = state.questions[currentQuestionIndex].options;
            _answerIndex = state.questions[currentQuestionIndex].answerIndex;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                QuestionTile(
                  question: question,
                ),
                SizedBox(
                  height: 550,
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _selectedIndex = index;
                          _checkAnswer();
                        },
                        child: AnswerTile(
                          color: getColor(index, answered),
                          content: options[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Circularindicator();
        },
      ),
    );
  }
}
