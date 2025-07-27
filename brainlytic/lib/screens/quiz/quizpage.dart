// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Quizpage extends StatefulWidget {
  final int qid;
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

  void _nextQuestion() async{
    
    if(_currentQuestionIndex < _totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
    else {
      await FirebaseFirestore.instance
      .collection('quizzes')
      .doc("quiz${widget.qid}")
      .update({
        'stars': _score,
      });
      if(context.mounted){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              
              title: const Text("Quiz Completed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
              ),
              content: Text("Your score is $_score out of $_totalQuestions",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Go back to the previous screen
                  },
                  child: const Text("OK",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  )
                )
              ],
            );
          }
        );
      }
    } 
  }
  
  void _checkAnswer(int selectedIndex) {
    if(selectedIndex == _answerIndex) {
      setState(() {
        _score++;
      });
    }
    _nextQuestion();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Question ${_currentQuestionIndex + 1}",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quizzes').doc("quiz${widget.qid}").collection('questions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
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
                height: 190,
                child: Text(snapshot.data!.docs[_currentQuestionIndex].data()['question'],
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        onPressed: () {
                          _checkAnswer(index);
                        },
                        child: Text(
                          snapshot.data!.docs[_currentQuestionIndex].data()['options'][index],
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
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