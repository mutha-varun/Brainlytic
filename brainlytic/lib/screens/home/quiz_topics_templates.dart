import 'package:brainlytic/screens/quiz/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizTopicsTemplates extends StatelessWidget {
  final Color color;
  final String title;
  final int id;
  final int stars;
  final int totalQuestions; 

  const QuizTopicsTemplates(
    {
      super.key,
      required this.color,
      required this.title,
      required this.id,
      required this.stars,
      required this.totalQuestions
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 285,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: color.withValues(alpha: 2),
            ),
            child: Text(title,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.star,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text("$stars/$totalQuestions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearPercentIndicator(
            percent: stars/totalQuestions,
            progressColor: Colors.white,
            width: 130,
            animation: true,
            barRadius: const Radius.circular(20),
            lineHeight: 15,
          ),
          const SizedBox(height: 35),
          Center(
            child: TextButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                    width: 2
                  ),
                )),
                fixedSize: WidgetStatePropertyAll(const Size(200, 50)),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Quizpage(
                      qid: id,
                    );
                  },
                ));
              }, 
              child: const Text("Start",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}