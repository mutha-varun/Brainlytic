import 'package:brainlytic/screens/quiz/answertile.dart';
import 'package:flutter/material.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Question 1",
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
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            child: Text("What is the capital of France?",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 370,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Answertile(
                    
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}