import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Quizpage extends StatefulWidget {
  final String qid;
  const Quizpage({
    required this.qid,
    super.key
  });
 

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _answerIndex = -1;
  int _totalQuestions = 0;
  int _selectedAnswer = -1;
  bool _isAnswered = false;
  bool _isFirst = true;

  Color getButtonColor(int index) {
    if (!_isAnswered) {
      return Pallete.blackColor;
    }
    if(index == _answerIndex) {
      return Pallete.correctAnsColor;
    }

    if(index == _selectedAnswer){
      return Pallete.redColor;
    }
    
    return Pallete.blackColor;

  }

  void _nextQuestion() async{
    
    if(_currentQuestionIndex < _totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
    else {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('userData').
      doc(userId)
      .collection('quizData')
      .doc("quiz${widget.qid}")
      .update({
        'stars': _score,
      });
      if(mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Quiz Completed",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium
              ),
              content: Text("Your score is $_score out of $_totalQuestions",
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.pop(); // Go back to the home screen
                  },
                  child: Text("OK",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Pallete.indigo700Color
                    )
                  )
                )
              ],
            );
          }
        );
      }
    } 
  }
  
  void _checkAnswer(int selectedIndex) async{

    setState(() {
      _selectedAnswer = selectedIndex;
      _isAnswered = true;
      if(selectedIndex == _answerIndex) {
        _score++;
      }
    });

    await Future.delayed(const Duration(milliseconds: 700));
    if(mounted){
      setState(() {
        _isAnswered = false;
        _selectedAnswer = -1;
      });
      _nextQuestion();
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${_currentQuestionIndex + 1}",
          style: Theme.of(context).textTheme.headlineMedium
        ),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quizzes').doc("quiz${widget.qid}").collection('questions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && _isFirst) {
            _isFirst = false; 
            return Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Circularindicator()
            );
          }

          if(!snapshot.hasData) {
            return Center(
              child: const Text("No question found")
            );
          }
          if(snapshot.hasData){
            _answerIndex = snapshot.data!.docs[_currentQuestionIndex].data()['answerIndex'];
            _totalQuestions = snapshot.data!.docs.length;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                child: Text(snapshot.data!.docs[_currentQuestionIndex].data()['question'],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
                      height: 85,
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                          backgroundColor: WidgetStatePropertyAll(getButtonColor(index))
                        ),
                        onPressed: (){
                          _checkAnswer(index);
                        },
                        child: Text(
                          snapshot.data!.docs[_currentQuestionIndex].data()['options'][index],
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}